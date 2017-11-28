// JavaScript: Toggle for Messages in Messages showpage

function hostedMessageToggle() {
  document.getElementById("hosted-title").onclick = function() {
    const hostedMessages = document.getElementById("hosted-message");
    hostedMessages.classList.toggle("hidden");
  };
}

hostedMessageToggle();

function scheduledMessageToggle() {
  document.getElementById("scheduled-title").onclick = function() {
    const scheduledMessages = document.getElementById("scheduled-message");
    scheduledMessages.classList.toggle("hidden");
  };
}

scheduledMessageToggle();

function interestedMessageToggle() {
  document.getElementById("interested-title").onclick = function() {
    const interestedMessages = document.getElementById("interested-message");
    interestedMessages.classList.toggle("hidden");
  };
}

interestedMessageToggle();
