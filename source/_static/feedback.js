document.addEventListener("DOMContentLoaded", function() {
    var btn = document.createElement("button");
    btn.id = "feedback-button";
    btn.textContent = "Geri Bildirim";
  
    btn.onclick = function() {
      // Buraya feedback formu URL'si ya da başka aksiyon ekle
      window.open("mailto:grid-teknik@ulakbim.gov.tr?subject=Dokümantasyon Geri Bildirimi", "_blank");
    };
  
    document.body.appendChild(btn);
  });
  document.getElementById("feedback-button").addEventListener("click", function() {
    window.location.href = "mailto:gridteknik@ulakbim.gov.tr?subject=Dokümantasyon%20Sayfas%C4%B1%20i%C3%A7in%20%C3%96neriler";
});

  