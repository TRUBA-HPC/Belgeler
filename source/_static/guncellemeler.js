document.addEventListener("DOMContentLoaded", function () {
    if (document.getElementById("duyurular-button")) {
        return;
    }

    var btn = document.createElement("button");
    btn.id = "duyurular-button";
    btn.textContent = "Güncellemeler";

    btn.onclick = function () {
        var contentRoot = document.documentElement.getAttribute("data-content_root") || "";
        window.location.href = contentRoot + "6-duyurular/index.html#guncellemeler";
    };

    document.body.appendChild(btn);
});
