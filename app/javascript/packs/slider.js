var arr = ['5', '10', '15', '20', '25']

var sliders = document.querySelectorAll('.range-slider');
sliders.forEach(slider => {
  slider.addEventListener('input', event => {
    console.log(event);
    var currentValue = event.target.value;

    var span = event.currentTarget.querySelector('span').innerText = arr[currentValue];

  })
})
