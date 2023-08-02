$(() => {

    $('body').hide();

    window.addEventListener('message', (event) => {
        const {action, type, data_hud, data_carhud, data_notification, data_radio, user_radio} = event.data;

        if(action){

            $('body').fadeIn(250);

            if(type == 'show:interfaz:hud'){
                buildDataHud(data_hud)
            };

            if(type == 'show:interfaz:carhud'){
                buildCarHud(data_carhud)
            };

            if(type == 'hide:interfaz:carhud'){
                $('.container-carhud').removeClass('fadeUp').addClass('fadeDown')

                setTimeout(() => {
                    $('.container-carhud').hide()
                }, 300)
            };

            if(type == 'show:interfaz:notification'){
                appendNotification(data_notification)
            };

        }else{
            $('body').fadeOut(250);
        };
    })
})