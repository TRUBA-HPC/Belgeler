===================
MATLAB on TRUBA HPC
===================

Introduction
============

This document describes how to configure and use MATLAB on the TRUBA
High-Performance Computing (HPC) infrastructure. It covers interactive
execution, batch job submission via Slurm, and local MATLAB integration.
TRUBA allows academic users to run heavy simulations faster using
high-end CPUs and GPUs, handle datasets too large for a standard laptop,
and run multiple MATLAB workers simultaneously to dramatically reduce
computation time. This guide is intended for academic users of TRUBA.

Tested Environment
==================

.. admonition:: Note

   **Note:** This documentation was validated under the following
   environment. Changes in MATLAB versions or Slurm settings may require
   minor adjustments.

================= ==================================================
Component         Version / Value
================= ==================================================
Cluster           TRUBA (arf and cuda)
Partitions Tested debug, orfoz, barbun-cuda
MATLAB            R2025b
License Model     Network Academic (MathWorks, expires 31 Dec 2027)
Slurm             23.02.5-1
OS                Rocky Linux 9
Test Date         2026-03-02
================= ==================================================

Prerequisites & Licensing
=========================

Ensure you have these three requirements ready before proceeding:

-  **Active TRUBA Account:** A valid username and password.
-  **VPN Connection:** OpenVPN must be active to access the cluster.
-  **Academic Purpose:** MATLAB on TRUBA is strictly for academic
   research. Commercial/corporate use is not permitted.

Licensing and Policy
--------------------

TRUBA provides MATLAB under a sponsored *Network Academic* license with the following terms:

.. list-table::
   :widths: 40 60
   :header-rows: 0

   * - License Type
     - Sponsored – Concurrent – Annual
   * - Valid Until
     - **31 December 2027**
   * - MATLAB + All Toolboxes
     - 200 concurrent seats (includes MATLAB Compiler)
   * - MATLAB Parallel Server
     - 4000 workers

.. admonition:: Important

   **Important:** Only *academic* MATLAB usage is permitted on TRUBA
   compute resources.

.. _what-this-means-in-practice:

What This Means in Practice
---------------------------

How the license is handled depends on how you choose to work:

-  **Using Open OnDemand or Batch Mode:** If you run MATLAB directly on
   the TRUBA cluster (via your web browser or a batch script), the
   license is provided and managed automatically on the cluster side.
   You do not need to provide your own.

-  **Using MATLAB on your Personal Computer:** If you write code in your
   local MATLAB and submit jobs to TRUBA using the cluster plugin, your
   local installation **must** be an *academic* license. If you use a
   commercial or trial license on your laptop, the remote execution will
   be blocked.

.. admonition:: Tip

   **To check your MATLAB license type:**

   #. Open MATLAB and type:

      .. code:: matlab

         ver

   #. If the license type is not shown, log in to your MathWorks account at
      https://www.mathworks.com/licensecenter
      and check under **My Licenses**.

   #. If you are still unsure, contact your university's software coordinator
      or IT department.

Choosing Your Workflow
======================

There are three supported methods for running MATLAB on TRUBA. Use the
table below to decide which one suits your situation.

+--------------------------------------------------+---------------------------------+--------------+
| If you want to…                                  | Use this method                 | Difficulty   |
+==================================================+=================================+==============+
| Launch a full MATLAB Desktop session on the      | Method A: Open OnDemand         | Beginner     |
| cluster (GUI via Open OnDemand)                  |                                 |              |
+--------------------------------------------------+---------------------------------+--------------+
| Develop locally and submit jobs to the cluster   | Method B: Local MATLAB + Plugin | Intermediate |
+--------------------------------------------------+---------------------------------+--------------+
| Run production jobs entirely via Slurm (no GUI)  | Method C: Slurm Batch Script    | Intermediate |
+--------------------------------------------------+---------------------------------+--------------+
| Use interactive parallel workers on cluster      | Advanced: Interactive parpool   | Advanced     |
| nodes                                            |                                 |              |
+--------------------------------------------------+---------------------------------+--------------+

.. admonition:: Note

   **Not sure which method to choose?** Method A (Open OnDemand) is the easiest
   way to get started, as it requires no local setup. However, because it runs
   as a remote GUI session, performance may be slower. For regular or heavy
   use, a local MATLAB setup connected to TRUBA is recommended (Method B).

.. _method-a-open-ondemand:

Method A — Open OnDemand (Interactive GUI)
==========================================

This method allows you to use a full graphical MATLAB interface directly
in your web browser via Open OnDemand. It is the best choice if you want
to work interactively and requires no local MATLAB installation.

.. admonition:: Important

   **Rule:** You must launch MATLAB through Open OnDemand. Running
   MATLAB directly on login nodes is strictly prohibited and will be
   terminated.

Connecting to the ARF Cluster
-----------------------------

#. Connect to **TRUBA OpenVPN**.
#. Open your browser and go to: https://172.16.6.20
#. Log in with your TRUBA username and password.
#. From the dashboard, click on **Interactive Apps** and select
   **Desktop**.

For detailed connection instructions refer to: https://docs.truba.gov.tr

.. figure:: /assets/matlab-howto/arf_ood_dashboard.png
   :alt: 

Starting MATLAB in the Desktop Session
--------------------------------------

Once your virtual desktop appears in the browser:

#. **Open a Terminal:** Right-click anywhere on the desktop and select
   *Open Terminal Here*.

#. **Load MATLAB:** Type the following commands to prepare the
   environment:

.. code:: bash

   module purge
   module available | grep -i matlab  # shows installed versions
   module load apps/matlab/r2025b

#. **Launch MATLAB:**

.. code:: bash

   matlab

Introducing MATLAB to the Cluster
---------------------------------

The first time you run MATLAB on TRUBA, it needs to detect its compute
environment. This step only needs to be done once.

#. In the MATLAB **Home** tab, click **Parallel** → **Discover
   Clusters…**
#. MATLAB will detect the compute node you were assigned (e.g.,
   ``orfoz34``).
#. Follow the prompts to finish.

.. figure:: /assets/matlab-howto/matlab_discover_clusters.png
   :alt: 

.. admonition:: Note

   **What does this step do?** This simply tells MATLAB that it is
   running on a TRUBA compute node. It does **not** set up long-term job
   submission. That is covered in :ref:`configuring-and-submitting-jobs-en`.

Alternative: Launching MATLAB Without the GUI
---------------------------------------------

Once the one-time "Introducing MATLAB to the Cluster" step above has
been completed, you do not need to launch the full graphical desktop
every time. Two lighter alternatives are available:

-  **Interactive command-line mode** (still accepts typed commands):

.. code:: bash

   matlab -nodesktop

-  **Non-interactive batch mode** (runs a script and exits
   automatically):

.. code:: bash

   matlab -batch "your_script_or_command"

.. admonition:: Tip

   **When to use which?** Use ``-nodesktop`` if you want to type
   commands interactively without the GUI overhead. Use ``-batch`` if
   you want to run a script fully automatically without any interaction.

If you open the *Cluster Profile Manager* (Home → Parallel → Cluster
Profile Manager) while using Open OnDemand, you may see a **Validate**
button. Do not use it on TRUBA — see :ref:`the-validate-button-en`.

Connecting to the CUDA Cluster
------------------------------

TRUBA has two main sections: **ARF** (standard CPU) and **CUDA**
(GPU-focused).

-  **ARF Access:** https://172.16.6.20
-  **CUDA Access:** https://172.16.6.16 *(Requires special
   authorization)*

For CUDA access requirements see:
https://docs.truba.gov.tr/1-kaynaklar/arf_acc/arf_acc_baglanti.html#arf-acc-baglanti

Your files, settings, and MATLAB preferences are shared between both
clusters, so no additional MATLAB configuration is needed when
switching.

-  **Home directory:** ``/arf/home/$USER``
-  **MATLAB preferences:** ``~/.matlab/R2025b/`` (cluster profiles and
   settings are stored here; shared between ARF and CUDA)

Next Steps
----------

Your MATLAB environment is now configured. To learn how to set job
parameters and submit your first job to the cluster, see
:ref:`configuring-and-submitting-jobs-en`.

Method B — Submit from Your Local MATLAB
========================================

This method allows you to write and develop your code in MATLAB on your
own computer and submit jobs directly to TRUBA without leaving the
MATLAB environment. It requires a one-time setup.

.. admonition:: Important

   **License reminder:** Method B requires a local MATLAB installation
   covered by a valid *academic* license. Commercial or trial licenses
   cannot submit jobs to TRUBA. See :ref:`what-this-means-in-practice`.
   If you do not have an academic license, use :ref:`method-a-open-ondemand`.

One-Time Setup
--------------

This setup must be performed once per cluster (ARF or CUDA) and must be
repeated if you install a new version of MATLAB locally.

Step 1: Verify Your User Path
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

MATLAB needs a specific folder to store the TRUBA connection scripts.

-  Open MATLAB on your computer.
-  Type ``userpath`` in the Command Window.
-  If it returns a folder path, that is where the plugin will be
   installed.
-  If it returns empty, reset it:

.. code:: matlab

   userpath('reset')
   userpath

.. figure:: /assets/matlab-howto/local_userpath_output.png
   :alt: 

If the folder does not exist yet, create it manually:

.. code:: matlab

   mkdir(fullfile(getenv('HOME'),'Documents','MATLAB'))
   userpath(fullfile(getenv('HOME'),'Documents','MATLAB'))
   savepath

Step 2: Install the TRUBA Cluster Plugin
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Download the **TRUBA MATLAB Plugin (ZIP)** updated on (11 May 2026):
   :download:`TRUBA MATLAB Plugin (ZIP) <../../../assets/matlab-howto/config-files/tubitak.Desktop.zip>`
-  Extract the contents directly into the folder returned by
   ``userpath``.
-  In the MATLAB Command Window, run:

.. code:: matlab

   configCluster

-  Follow the prompts: select the cluster (ARF or CUDA) and enter your
   **TRUBA username**.

.. admonition:: Note

   **No password required yet.** You will be asked for your password
   only when you actually submit a job to the cluster.

.. figure:: /assets/matlab-howto/configcluster_execution.png
   :alt: 

After successful configuration, jobs submitted from your local MATLAB
will run on the TRUBA cluster. You can verify the profile was created by
going to Home → Parallel → Create and Manage Clusters.

.. figure:: /assets/matlab-howto/cluster_profile_manager.png
   :alt: 

.. _the-validate-button-en:

The "Validate" Button
~~~~~~~~~~~~~~~~~~~~~

If you open the *Cluster Profile Manager* (Home → Parallel → Cluster
Profile Manager), you may see a **Validate** button.

.. admonition:: Important

   **Do not use the "Validate" button here.** On TRUBA, job execution is
   handled by the Slurm scheduler, not MATLAB's internal validator. The
   validation test will likely fail, but this **does not** mean your
   MATLAB is broken. As long as you can run commands, your setup is
   correct.

Step 3: ARF and CUDA Cluster Profiles
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ARF and CUDA are separate Slurm systems and each requires its own
cluster profile. If you have access to both, repeat the
``configCluster`` step and select the CUDA cluster when prompted.

For CUDA access requirements see:
https://docs.truba.gov.tr/1-kaynaklar/arf_acc/arf_acc_baglanti.html#arf-acc-baglanti

Switching Between Your Computer and the Cluster
-----------------------------------------------

You can tell MATLAB where to run your work with a single command. This
is useful for testing code locally before sending it to TRUBA.

-  **To work on TRUBA (default after setup):**

.. code:: matlab

   c = parcluster;  % loads your default TRUBA profile

-  **To work on your local computer:**

.. code:: matlab

   c = parcluster('Processes');  % uses your computer's own processors

.. admonition:: Tip

   **Tip:** Think of the ``Processes`` profile as your personal
   workspace and the TRUBA profile as the heavy-duty factory. Only send
   work to the factory when it is too big for your workspace!

If you do not see a ``Processes`` profile in your list, add it manually:

#. Go to Home → Parallel → Create and Manage Clusters.
#. Click **Add Cluster Profile** → **Processes**.

.. _next-steps-1:

Next Steps
----------

Your local MATLAB is now configured to submit jobs to TRUBA. To learn
how to set job parameters and submit your first job to the cluster, see
:ref:`configuring-and-submitting-jobs-en`.

.. _method-c-slurm-batch-script-en:

Method C — Slurm Batch Script
=============================

This method runs MATLAB entirely inside a Slurm allocation. You write a
standard Slurm job script, and MATLAB creates a parallel pool using the
CPUs already allocated by Slurm. No cluster profile or plugin is
required.

.. admonition:: Note

   **When to use this method?** This is the most direct HPC approach and
   requires no local MATLAB installation or plugin setup. It is
   particularly suitable for users already familiar with Slurm job
   scripts.

   If you need a quick refresher on Slurm job scripts, see:
   https://docs.truba.gov.tr/2-temel_bilgiler/slurm-betik-ozellik.html

What You Need
-------------

-  A MATLAB script saved on TRUBA under ``/arf/scratch/$USER``.
-  A Slurm job script (``.sh`` file) that loads MATLAB and runs your
   code.
-  Basic familiarity with Slurm partitions and wall time. See
   :ref:`configuring-and-submitting-jobs-en` for details.

Step 1: Write Your MATLAB Script
--------------------------------

Save your MATLAB script under ``/arf/scratch/$USER``. Your script
should:

#. Read the number of workers from the environment variable
   ``NUM_WORKERS`` (set automatically by the Slurm script).
#. Create a parallel pool using those already-allocated CPUs.
#. Run your computation.
#. Clean up the pool at the end.

.. code:: matlab

   % your_script.m

   % Read number of workers passed in from Slurm
   n = str2double(getenv("NUM_WORKERS"));

   % Create a pool from the CPUs already allocated by Slurm.
   % This does NOT submit a new Slurm request — it simply uses
   % the resources Slurm has already given to this job.
   % (This is different from Method B where MATLAB itself talks to Slurm.)
   parpool('Processes', n);  % local worker processes on the compute node

   % --- Your computation goes here ---

   % Minimal example computation ("sleep") — can be removed.
   % Each worker pauses for 1 second; total time should be ~1 second.
   tic;
   parfor i = 1:n
       pause(1);
   end
   elapsed = toc;
   fprintf('parfor demo finished in %.2f seconds.\n', elapsed);

   % Clean up
   delete(gcp('nocreate'));

.. admonition:: Note

   **Note:** ``NUM_WORKERS`` is set automatically by the Slurm script
   below. If you change the number of CPUs in the Slurm script, the
   worker count adjusts automatically — no need to edit your MATLAB
   code. In the Slurm output, you may see MATLAB starting the pool using
   the ``Processes`` profile; this is expected and indicates a local pool
   running on the allocated compute node.

Step 2: Write Your Slurm Script
-------------------------------

Save the following as ``submit_job.sh`` in the same directory:

.. code:: bash

   #!/bin/bash
   #SBATCH -J matlab-job             # job name
   #SBATCH -A $USER                  # account name
   #SBATCH -p orfoz                  # partition
   #SBATCH -N 1                      # number of nodes
   #SBATCH --ntasks=56               # orfoz requires 56xn cores per node
   #SBATCH --cpus-per-task=1
   #SBATCH -t 0-00:30                # wall time
   #SBATCH -o matlab-job_%j.out      # standard output file
   #SBATCH -e matlab-job_%j.err      # standard error file

   module load apps/matlab/r2025b

   # One core runs the MATLAB client, the rest are workers
   export NUM_WORKERS=$((SLURM_NTASKS - 1))  # = 55 workers

   matlab -batch "your_script"

.. admonition:: Tip

   **Note on core counts:** ``orfoz`` requires cores to be requested in
   multiples of 56 per node. With ``--ntasks=56``, one core runs the
   MATLAB client and 55 become parallel workers. Partition-specific
   rules for other partitions are covered in
   :ref:`configuring-and-submitting-jobs-en`.

Step 3: Submit and Monitor Your Job
-----------------------------------

Submit the job from the TRUBA login node:

.. code:: bash

   sbatch submit_job.sh

Check job status:

.. code:: bash

   squeue -u $USER

After the job completes, inspect the output file:

.. code:: bash

   cat matlab-job_<jobid>.out

.. _next-steps-2:

Next Steps
----------

For a deeper understanding of partition rules, memory, and resource
selection — which apply to all three methods — see
:ref:`configuring-and-submitting-jobs-en`.

.. _configuring-and-submitting-jobs-en:

Configuring and Submitting Jobs
===============================

This section applies to **Method A** (Open OnDemand) and **Method B**
(Local MATLAB). Method C (Slurm Batch Script) handles resource requests
directly in the Slurm script — see :ref:`method-c-slurm-batch-script-en`.

Before submitting jobs, it is recommended to have basic familiarity with
Slurm concepts:

-  Slurm job script fundamentals:
   https://docs.truba.gov.tr/2-temel_bilgiler/slurm-betik-ozellik.html
-  Overview of TRUBA partitions:
   https://docs.truba.gov.tr/2-temel_bilgiler/hesaplama_kumeleri.html

The Three Things You Must Set
-----------------------------

Every job submission requires at least these three parameters:

.. code:: matlab

   c = parcluster;

   c.AdditionalProperties.Partition = 'debug';   % which partition to use
   c.AdditionalProperties.NumNodes  = 1;         % number of nodes
   c.AdditionalProperties.WallTime  = '0-00:10'; % max runtime (D-HH:MM)

-  **Partition:** Determines which nodes your job runs on. For initial
   testing always use ``debug``. For production jobs choose the
   partition that matches your workload type (CPU, memory, or GPU). See
   the partition reference tables below.

-  **NumNodes:** Always set this explicitly. If left unset, Slurm may
   distribute tasks across nodes in a way that violates per-node core
   policies.

-  **WallTime:** Required. Keep it short for tests (e.g. 10 minutes).
   Upper limits depend on the partition — you can check them with
   ``scontrol show partition`` on the TRUBA login node.

Listing Available Partitions
----------------------------

To get a quick list of available partitions from within MATLAB:

.. code:: matlab

   c = parcluster;
   clusterPartitionNames(c)

Example output:

::

   {'akya-cuda'  }
   {'barbun'     }
   {'barbun-cuda'}
   {'debug'      }
   {'hamsi'      }
   {'orfoz'      }
   {'smp'        }

.. admonition:: Note

   **Note:** Online documentation may not always reflect the most
   current partition configuration. Use ``clusterPartitionNames`` for a
   quick list from within MATLAB, or ``scontrol show partition`` on the
   login node for full partition details including memory limits and
   maximum wall time.

Saving and Modifying Settings
-----------------------------

By default, changes to ``AdditionalProperties`` are not saved between
MATLAB sessions.

To view all current settings:

.. code:: matlab

   c.AdditionalProperties

Once you know which parameters you need, you can modify a setting:

.. code:: matlab

   c.AdditionalProperties.WallTime = '0-00:30';

To unset a value and return to plugin defaults:

.. code:: matlab

   c.AdditionalProperties.Partition = '';
   c.AdditionalProperties.NumNodes  = 0;
   c.AdditionalProperties.MemPerCPU = '';
   c.AdditionalProperties.RequireExclusiveNode = false;

To make your settings persistent between MATLAB sessions (save after you
make changes):

.. code:: matlab

   c.saveProfile

Submitting a Job
----------------

Use the ``batch`` command to submit a job to the cluster:

.. code:: matlab

   j = batch(c, @your_function, 1, {}, ...
       'Pool', 2, ...
       'CurrentFolder', '.', ...
       'AutoAddClientPath', false);

Explanation of arguments:

-  ``c`` — the TRUBA cluster profile
-  ``@your_function`` — the function to run on the cluster (for a quick
   smoke test, you can use ``@pwd`` which returns the working directory
   on TRUBA)
-  ``1`` — number of output arguments expected
-  ``{}`` — input arguments (empty in this example)
-  ``'Pool', 2`` — number of parallel workers
-  ``'CurrentFolder', '.'`` — working directory on the cluster
-  ``'AutoAddClientPath', false`` — prevents MATLAB from trying to add
   local paths to cluster workers (avoids unnecessary warnings)

Once submitted, the job enters the Slurm queue and runs entirely on
TRUBA. You may close MATLAB or your desktop session — the job continues
running.

The Pool+1 Rule
---------------

.. admonition:: Important

   **Total Slurm tasks = Pool size + 1**

   When you request a Pool of workers, MATLAB uses one additional task
   for job orchestration. A Pool of 2 therefore requests 3 Slurm tasks.
   This matters because some partitions enforce strict per-node core
   counts.

Example: to request exactly **56 cores** on ``orfoz``, set
``Pool = 55``:

.. code:: matlab

   j = batch(c, @your_function, 1, {}, ...
       'Pool', 55, ...
       'CurrentFolder', '.', ...
       'AutoAddClientPath', false);

.. admonition:: Note

   **Method C only:** In Slurm batch scripts, the Pool+1 rule does not
   apply — worker count is handled automatically by
   ``SLURM_NTASKS - 1``.

Partition Reference: CPU Partitions
-----------------------------------

========== ========== =================== ==========================
Partition  Cores/Node Mem/CPU             Notes
========== ========== =================== ==========================
``debug``  flexible   —                   For testing only
``orfoz``  112        ~2000 MB            Must request 56×n cores
``hamsi``  56         ~3400 MB            Must request 56×n cores
``barbun`` 40         ~8500 MB            Must request 40×n cores
``smp``    224        3400 MB (max 17000) Single node: ``orkinos1``
========== ========== =================== ==========================

Core Count Rules
~~~~~~~~~~~~~~~~

Some partitions enforce strict per-node core count policies. If
violated, Slurm rejects the job with an error message.

-  ``orfoz`` — must request **56×n** cores per node (56 or 112)
-  ``hamsi`` — must request **56×n** cores per node
-  ``barbun`` — must request **40×n** cores per node

.. admonition:: Important

   **Remember the Pool+1 rule.** To request 56 cores on ``orfoz``, set
   ``Pool = 55``.

Example rejected job message:

::

   sbatch: error: Orfoz kuyruguna gonderilen islerde node basina
   56/112 cekirdek talep ediniz.

Partition Reference: GPU Partitions
-----------------------------------

=============== ========== ========= ======== ============
Partition       Cores/Node GPUs/Node Mem/CPU  CPUs per GPU
=============== ========== ========= ======== ============
``barbun-cuda`` 40         2         ~8500 MB 20
``akya-cuda``   40         4         ~8500 MB 10
=============== ========== ========= ======== ============

GPU Request Rules
~~~~~~~~~~~~~~~~~

GPU partitions enforce both a mandatory GPU request and a strict
CPU-to-GPU ratio.

-  ``barbun-cuda``

   -  GPU request is mandatory.
   -  Must request **20×n** CPU cores per GPU per node.
   -  A full node: 2 GPUs + 40 CPUs.

-  ``akya-cuda``

   -  GPU request is mandatory.
   -  Must request **10×n** CPU cores per GPU per node.
   -  A full node: 4 GPUs + 40 CPUs.

To request GPUs from MATLAB:

.. code:: matlab

   c.AdditionalProperties.GPUsPerNode = 2;

.. admonition:: Important

   **If you previously set a node constraint** (e.g. ``orfoz`` for
   testing), clear it before submitting to GPU partitions:

   .. code:: matlab

      c.AdditionalProperties.Constraint = '';

   Otherwise Slurm may not find a matching node.

Example rejected job messages:

::

   barbun-cuda kuyruguna sadece GPU talebi olan isler gonderilebilir.

::

   sbatch: error: Too few CPUs requested for the number of GPUs.

Memory Model
------------

On TRUBA, memory allocation scales with the number of requested CPU
cores — you do not request memory directly. Requesting more cores gives
you proportionally more memory. The memory figures are already shown in
the partition tables above.

.. admonition:: Tip

   **Memory-heavy jobs:** If your job needs more memory than it needs
   CPU cores, choose a partition with a higher memory-per-CPU ratio.
   ``barbun`` (~8500 MB/CPU) is often the best choice for memory-heavy
   workloads. For extreme memory requirements, consider ``smp``.

.. admonition:: Note

   **Responsible usage:** Do not request excessive cores just to get
   more memory if the extra cores will remain idle. Choose the partition
   that gives you the right memory-per-CPU ratio instead.

Monitoring and Retrieving Results
---------------------------------

While the Job is Running
~~~~~~~~~~~~~~~~~~~~~~~~

Check job state from MATLAB:

.. code:: matlab

   j.State

Possible states:

-  ``queued`` — waiting in the Slurm queue
-  ``running`` — currently executing
-  ``finished`` — completed successfully
-  ``failed`` — an error occurred

To block MATLAB until the job finishes (useful for short test jobs):

.. code:: matlab

   wait(j)

To check from the TRUBA login node:

.. code:: bash

   squeue -u $USER

After completion:

.. code:: bash

   sacct -j <jobid> --format=JobID,State,Elapsed,AllocCPUS,NodeList

Coming Back to a Completed Job
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For longer jobs you will likely close MATLAB after submission and return
later. To reconnect to your jobs:

.. code:: matlab

   c = parcluster;
   c.Jobs          % lists all jobs associated with this profile

``c.Jobs`` returns a list of all jobs with their ID, state, and
submission time. If you submitted multiple jobs, use this to identify
which one you want:

.. code:: matlab

   % Select by position (most recent job)
   j = c.Jobs(end);

   % Or select by ID if you noted it at submission time
   j = c.findJob('ID', 4);

Retrieving Results
~~~~~~~~~~~~~~~~~~

#. Function output (fetchOutputs)

   If your job was submitted as a function that returns values, retrieve
   them with:

   .. code:: matlab

      out = fetchOutputs(j);
      out{1}    % outputs are always returned as a cell array

   This is the most convenient method for test jobs and functions that
   return small results.

#. File output

   For production jobs, your MATLAB code will typically write results
   directly to disk using ``save()`` or similar. These files are written
   to the ``CurrentFolder`` you specified in the ``batch`` call.

   .. admonition:: Important

      **Where are the files?**

      -  **Method A (Open OnDemand):** Files are written on the cluster
         under the ``CurrentFolder`` you specified — typically
         ``/arf/scratch/$USER``. They are accessible directly from the
         TRUBA filesystem.
      -  **Method B (Local MATLAB):** Files are written on the
         **cluster**, not on your local machine. You need to either SSH
         into TRUBA to access them, or copy them to your local machine
         using ``scp`` or ``sftp``.

#. Viewing printed output

   To see everything MATLAB printed to the command window during
   execution:

   .. code:: matlab

      diary(j)

If the Job Failed
~~~~~~~~~~~~~~~~~

.. code:: matlab

   j.State            % confirm it is 'failed'
   j.Tasks(1).Error   % view the error message
   diary(j)           % view all printed output including errors

If you need to report the issue to TRUBA support, retrieve the Slurm job
ID:

.. code:: matlab

   j.getTaskSchedulerIDs()

Cleaning Up
~~~~~~~~~~~

To delete a single completed job and its local metadata:

.. code:: matlab

   delete(j)

To delete all jobs associated with the profile:

.. code:: matlab

   c = parcluster;
   delete(c.Jobs)

Advanced: Interactive parpool from Desktop
==========================================

This section describes how to launch a parallel pool on TRUBA directly
from MATLAB running on your personal computer. Once the pool is
connected, your ``parfor`` loops run on cluster workers transparently as
if they were running locally.

.. admonition:: Note

   **Requirements:** VPN must be active and TCP port 27370 must be open
   for inbound traffic on your machine.

Setting Up the Connection
-------------------------

Before starting the pool, run the following command to advertise your
VPN IP address to the TRUBA worker nodes:

.. code:: matlab

   sethostname

Expected output:

::

   Found private IP address.  Setting hostname: 10.x.x.x

Run this command each time you restart MATLAB.

If your firewall blocks communication, you may see:

::

   Check whether a firewall is blocking communication between the
   worker machines and the MATLAB client machine.

Starting a Parallel Pool on TRUBA
---------------------------------

Configure the cluster profile as usual (see
:ref:`configuring-and-submitting-jobs-en` for partition rules and memory
guidance), then start the pool:


.. code:: matlab

   c = parcluster;

   c.AdditionalProperties.Partition = 'orfoz';
   c.AdditionalProperties.NumNodes  = 1;
   c.AdditionalProperties.WallTime  = '0-00:30';

   pool = parpool(c, 56);

.. admonition:: Note

   ``parpool(c, 56)`` internally submits a Slurm job requesting 56
   workers. All TRUBA partition constraints apply — for example,
   ``orfoz`` requires 56×n cores per node. The pool remains active and
   holds cluster resources until you explicitly delete it.

This startup phase can take from tens of seconds to several minutes
while MATLAB submits the Slurm job, starts worker processes, checks
licenses, and establishes TCP connections.

Running Code Interactively
--------------------------

Once the pool is connected, your ``parfor`` loops run on cluster workers
transparently. A quick test to verify the pool is working:

.. code:: matlab

   tic; parfor i = 1:56, pause(1); end; toc

With 56 workers each iteration runs simultaneously, so the total elapsed
time should be close to 1 second instead of 56 seconds. This confirms
the pool is active and workers are being utilized.

Monitoring the Pool
-------------------

To view active pools and jobs, open the Job Monitor:

Parallel → Monitor Jobs

.. figure:: /assets/matlab-howto/open_job_monitor.png
   :alt: 

.. figure:: /assets/matlab-howto/job_monitor_window.png
   :alt: 

.. admonition:: Note

   When a pool is active the Job Monitor shows *Description: Interactive
   pool* and *State: running*. This means workers are allocated and
   ready — it does **not** necessarily mean a ``parfor`` loop is
   currently executing. As long as the pool remains open, cluster
   resources stay allocated.

Closing the Pool
----------------

Always delete the pool when you are finished:

.. code:: matlab

   delete(gcp('nocreate'))

Idle pools may be terminated automatically after approximately 30
minutes of inactivity, but do not rely on this.

Troubleshooting
---------------

If the pool fails to connect, for example after reconnecting to VPN, you
can try:

.. code:: matlab

   fixConnection

.. _next-steps-3:

Next Steps
----------

Helper Functions
================

TRUBA provides several helper functions that simplify interaction with
Slurm and cluster resources from within MATLAB. All functions that query
cluster properties require an active cluster profile object — run them
from MATLAB after calling ``c = parcluster``.

+----------------------------+-----------------------+----------------------+
| Function                   | Description           | Notes                |
+============================+=======================+======================+
|| ``clusterPartitionNames`` || Lists available      || Verify before       |
||                           || Slurm partitions     || setting partition   |
+----------------------------+-----------------------+----------------------+
|| ``clusterFeatures``       || Lists cluster        || Useful for          |
||                           || features and node    || understanding       |
||                           || constraints          || partition rules     |
+----------------------------+-----------------------+----------------------+
|| ``clusterGpuCards``       || Lists available GPU  || Use before          |
||                           || models on TRUBA      || requesting GPU      |
||                           ||                      || resources           |
+----------------------------+-----------------------+----------------------+
|| ``fixConnection``         || Reestablishes        || Applicable only for |
||                           || cluster connection   || interactive parpool |
+----------------------------+-----------------------+----------------------+
|| ``seff``                  || Displays Slurm       || Use after job       |
||                           || efficiency stats for || completes           |
||                           || a job                ||                     |
+----------------------------+-----------------------+----------------------+
|| ``willRun``               || Explains why a job   || Use while job is    |
||                           || is queued            || waiting             |
+----------------------------+-----------------------+----------------------+

Usage
-----

.. code:: matlab

   % Cluster query functions — require cluster profile object
   c = parcluster;
   clusterPartitionNames(c)
   clusterFeatures(c)
   clusterGpuCards(c)

   % Job functions — require MATLAB job object
   % j is returned by batch(), or retrieved via c.Jobs
   seff(j)      % after job completes
   willRun(j)   % while job is queued

Interpreting seff Output
------------------------

``seff(j)`` returns a summary of how efficiently your job used the
resources it was allocated. Example output:

::

   ID: 5335910
   Cluster: arf
   User/Group: username/username
   State: COMPLETED (exit code 0)
   Nodes: 1
   Cores per node: 56
   CPU Utilized: 00:22:41
   CPU Efficiency: 22.50% of 01:40:48 core-walltime
   Job Wall-clock time: 00:01:48
   Memory Utilized: 50.29 GB
   Memory Efficiency: 45.98% of 109.38 GB

The two most useful numbers for tuning future job submissions are:

-  **CPU Efficiency:** 22.50% means workers were idle for most of the
   job. Either the workload was too small to keep 56 workers busy, or
   there was a load imbalance between iterations. Consider reducing the
   pool size or increasing the workload per iteration.

-  **Memory Efficiency:** 45.98% means roughly half the allocated memory
   went unused. Since memory on TRUBA scales with the number of
   requested cores, you may be able to request fewer cores on the next
   run and still have sufficient memory.

.. admonition:: Tip

   Run ``seff`` after every job while you are still tuning your resource
   requests. Once CPU and memory efficiency are consistently high you
   have found the right configuration for your workload.

.. _troubleshooting-1:

Troubleshooting
===============

Job Failed: Retrieving Debug Logs
---------------------------------

If a batch job fails, use ``getDebugLog`` to retrieve detailed error
messages from the MATLAB workers on TRUBA.

For pool jobs:

.. code:: matlab

   c.getDebugLog(job)

For independent jobs (multiple tasks):

.. code:: matlab

   c.getDebugLog(job.Tasks)

Retrieving the Slurm Job ID
---------------------------

If you need to report a problem to TRUBA support, they may ask for the
Slurm job ID. Retrieve it with:

.. code:: matlab

   job.getTaskSchedulerIDs()

Example output:

::

   ans =
       25539

This corresponds to the Slurm job ID visible via ``squeue`` or ``sacct``
on the TRUBA login node.

Licensing Issues
----------------

MATLAB jobs on TRUBA require:

-  A valid **academic license** on your local MATLAB installation
-  The **Parallel Computing Toolbox** for ``parpool`` and ``batch`` with
   ``Pool``

TRUBA's network license is already configured — you do not need to set
up anything on the cluster side.

Checking Your Local License
~~~~~~~~~~~~~~~~~~~~~~~~~~~

To verify whether your local MATLAB installation has the Parallel
Computing Toolbox:

.. code:: matlab

   license('test', 'Distrib_Computing_Toolbox')
   % Returns 1 if available, 0 if not

To see all toolboxes currently checked out in your session:

.. code:: matlab

   license('inuse')

To see all toolboxes installed with your MATLAB:

.. code:: matlab

   ver

.. admonition:: Note

   Academic licenses are required for cluster submission via the plugin
   (Method B). If you are unsure whether your institutional license
   covers the Parallel Computing Toolbox, check with your institution's
   MATLAB license administrator.

Symptoms of a Licensing Problem
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Job fails immediately after submission
-  Workers cannot start
-  ``parpool`` hangs or reports license checkout failures

If You Suspect a TRUBA-Side License Issue
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Contact TRUBA support and include:

-  The Slurm job ID (``job.getTaskSchedulerIDs()``)
-  The debug log (``c.getDebugLog(job)``)
-  The exact error message from ``j.Tasks(1).Error``

Further Reading
===============

To learn more about MATLAB Parallel Computing Toolbox, the following
official MathWorks resources may be helpful:

-  `Parallel Computing Overview <https://www.mathworks.com/products/parallel-computing/index.html>`_
-  `Parallel Computing Documentation <https://www.mathworks.com/help/parallel-computing/>`_
-  `Parallel Computing Coding Examples <https://www.mathworks.com/help/parallel-computing/examples.html>`_
-  `Parallel Computing Tutorials <https://www.mathworks.com/products/parallel-computing/tutorials.html>`_
-  `Parallel Computing Videos <https://www.mathworks.com/products/parallel-computing/videos.html>`_
-  `Parallel Computing Webinars <https://www.mathworks.com/products/parallel-computing/webinars.html>`_

These resources cover general usage of parallel computing within MATLAB
and are not specific to TRUBA cluster configuration.

Quick Reference
===============

Essential Settings
------------------

.. code:: matlab

   c = parcluster;

   c.AdditionalProperties.Partition = 'debug';   % partition name
   c.AdditionalProperties.NumNodes  = 1;         % number of nodes
   c.AdditionalProperties.WallTime  = '0-00:10'; % max runtime (D-HH:MM)

Always start with ``debug`` for testing. Change partition for production
jobs.

.. _submitting-a-job-1:

Submitting a Job
----------------

.. code:: matlab

   j = batch(c, @your_function, 1, {}, ...
       'Pool', N, ...
       'CurrentFolder', '.', ...
       'AutoAddClientPath', false);

.. _the-pool1-rule-1:

The Pool+1 Rule
---------------

::

   Total Slurm tasks = Pool + 1

MATLAB uses one extra task for orchestration. On partitions with strict
core count policies this matters:

=============== ========== ===========
Partition       Cores/Node Set Pool to
=============== ========== ===========
``orfoz``       56         55
``orfoz``       112        111
``hamsi``       56         55
``barbun``      40         39
``barbun-cuda`` (GPU) 40         39
``akya-cuda``   (GPU) 40         39
=============== ========== ===========

.. _monitoring-and-retrieving-results-1:

Monitoring and Retrieving Results
---------------------------------

.. code:: matlab

   j.State              % queued / running / finished / failed
   wait(j)              % block until job completes
   diary(j)             % view printed output from workers
   out = fetchOutputs(j); out{1}   % retrieve function return value
   j.Tasks(1).Error     % view error if job failed
   c.getDebugLog(j)     % detailed worker error log

From the login node:

.. code:: bash

   squeue -u $USER
   sacct -j <jobid> --format=JobID,State,Elapsed,AllocCPUS,NodeList

.. _coming-back-to-a-completed-job-1:

Coming Back to a Completed Job
------------------------------

.. code:: matlab

   c = parcluster;
   c.Jobs        % list all jobs
   j = c.Jobs(end);          % most recent job
   j = c.findJob('ID', 4);   % specific job by ID

Saving Settings
---------------

.. code:: matlab

   c.saveProfile             % persist settings between sessions
   c.AdditionalProperties    % view all current settings

Example: CPU Job on ``orfoz`` (56-core half-node)
-------------------------------------------------

.. code:: matlab

   c = parcluster;
   c.AdditionalProperties.Partition = 'orfoz';
   c.AdditionalProperties.NumNodes  = 1;
   c.AdditionalProperties.WallTime  = '0-00:10';

   j = batch(c, @pwd, 1, {}, ...
       'Pool', 55, ...
       'CurrentFolder', '.', ...
       'AutoAddClientPath', false);

   wait(j);
   out = fetchOutputs(j);
   out{1}    % should return your working directory on TRUBA

Example: GPU Job on ``barbun-cuda`` (2 GPUs, 40 CPUs)
-----------------------------------------------------

.. code:: matlab

   c = parcluster;
   c.AdditionalProperties.Partition  = 'barbun-cuda';
   c.AdditionalProperties.NumNodes   = 1;
   c.AdditionalProperties.WallTime   = '0-00:10';
   c.AdditionalProperties.GPUsPerNode = 2;

   j = batch(c, @gpuDeviceCount, 1, {}, ...
       'Pool', 39, ...
       'CurrentFolder', '.', ...
       'AutoAddClientPath', false);

   wait(j);
   out = fetchOutputs(j);
   out{1}    % should return 2 (number of GPUs visible to worker)

   
