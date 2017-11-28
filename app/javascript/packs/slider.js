
// Distance slider
var arrDistance = ['<5km', '<10km', '<15km']

var sliders = document.querySelectorAll('.distance');
sliders.forEach(slider => {
  slider.addEventListener('input', event => {
    console.log(event);
    var currentValue = event.target.value;

    var span = event.currentTarget.querySelector('span').innerText = arrDistance[currentValue];

  })
})

// Distance slider
var arrSocial = ['<i class="fa fa-headphones" aria-hidden="true"></i>', '<i class="fa fa-smile-o" aria-hidden="true"></i>', '<i class="fa fa-handshake-o" aria-hidden="true"></i>']

var sliders = document.querySelectorAll('.sociability');
sliders.forEach(slider => {
  slider.addEventListener('input', event => {
    console.log(event);
    var currentValue = event.target.value;

    var span = event.currentTarget.querySelector('span').innerHTML = arrSocial[currentValue];

  })
})

// Pace slider
var arrPace = ['3:00', '3:15', '3:30', '3:45',
  '4:00','4:15','4:30', '4:45',
  '5:00', '5:15', '5:30', '5:45',
  '6:00', '6:15', '6:30', '6:45',
  '7:00']

var sliders = document.querySelectorAll('.pace');
sliders.forEach(slider => {
  slider.addEventListener('input', event => {
    console.log(event);
    var currentValue = event.target.value;

    var span = event.currentTarget.querySelector('span').innerText = arrPace[currentValue];

  })
})
