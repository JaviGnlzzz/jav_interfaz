const buildCarHud = (data) => {

    $('.container-carhud').show().removeClass('fadeDown').addClass('fadeUp')

    const {speed, gear, rpm, status, seatbelt_status, gas} = data;

    if (speed.toString().substring(1, 2) == ''){
        $('.speed-text').html('<span class="off-text">00</span>' + speed)
    }else if(speed.toString().substring(2, 3) == ''){
        $('.speed-text').html('<span class="off-text">0</span>' + speed)
    }else{
        $('.speed-text').html(speed)
    };

    if(gear == 0 && speed == 0){
        $('.gear-text').text('N')
    }else if(gear == 0 && speed > 0){
        $('.gear-text').text('R')
    }else{
        $('.gear-text').text(gear)
    };

    if (status <= 60) {
        $('.engine').css({'color': 'rgb(216, 198, 40)', 'animation': 'pulse .8s infinite'});
    } else {
        $('.engine').css({'color': 'rgba(255, 255, 255, 0.089)', 'animation': 'none'});
    };      

    if(seatbelt_status){
        $('.functions-rpm-part img').attr('src', './assets/belt-on.png');
        $('.functions-rpm-part img').css({'opacity' : '1','animation': 'none'});
    }else{
        $('.functions-rpm-part img').attr('src', './assets/belt.png');
        $('.functions-rpm-part img').css({'animation': 'flash 2s infinite'});
    };

    if(gas <= 65){
        $('.gas-part').fadeIn();
        $('.gas-text').text(gas + '%')
    }else{
        $('.gas-part').fadeOut();
    }

    $('.rpm-progress-left, .rpm-progress-right').css({'width' : (rpm - 15) + '%'})

};