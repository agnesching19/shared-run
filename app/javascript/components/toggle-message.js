function hostedMessageToggle() {
  document.getElementById("hosted-title").onclick = function() {
    const hostedMessages = document.getElementById("hosted-message");
    hostedMessages.classList.toggle("hidden");
  };
}

hostedMessageToggle();
