let id = 0
var borrar = []
var deleting = false

const appendNotification = (data) => {

    const {text, type} = data;

    const type_notification = {
        bank : '<i class="fa-duotone fa-piggy-bank"></i>',
        default : '<i class="fa-duotone fa-info"></i>',
        success : '<i class="fa-duotone fa-badge-check"></i>',
        error : '<i class="fa-duotone fa-triangle-exclamation"></i>',
        admin : '<i class="fa-duotone fa-hammer"></i>',
        radio : '<i class="fa-duotone fa-walkie-talkie"></i>',
        car : '<i class="fa-duotone fa-car"></i>'
    }

    id++

    let count = id

    if(type in type_notification){
        $('.interfaz-notifications').append(`
            <div class="item-notification" id="notification-${count}">
                <div class="icon-notification">${type_notification[type]}</div>
                <div class="text-notification">${text}</div>

                <div class="progress-bar">
                    <div class="bar-progress" id="progress-${count}"></div>
                </div>
            </div>
        `);

        Progress(count)
    }else{
        $('.interfaz-notifications').append(`
            <div class="item-notification" id="notification-${count}">
                <div class="icon-notification">${type_notification.default}</div>
                <div class="text-notification">${text}</div>

                <div class="progress-bar">
                    <div class="bar-progress" id="progress-${count}"></div>
                </div>
            </div>
        `); 

        Progress(count)
    };

};

function Progress(id){
    $(`#progress-${id}`).animate({'height': '100%'}, 4000)

    setTimeout(function(){
        Borrar(id)
    }, 4000)

};

function Borrar(id) {
    if (!deleting) {
        deleting = true
        let height = document.querySelector(`#notification-${id}`).offsetHeight;
        $('.interfaz-notifications').css({'transition' : '.5s','transform': `translateY(${height + (3.5 * 1.6)}px)`})
        $(`#notification-${id}`).css({'opacity': '0', 'transform': 'translateY(0vw)'})
        setTimeout(function(){
            deleting = false

            $(`#notification-${id}`).remove();
            
            $('.interfaz-notifications').css({'transition' : '0s', 'transform': `translateY(0)`})  

            if (borrar.length > 0) {
                Borrar(borrar.shift()) 
            };

        }, 750)
    }else {
        borrar.push(id)
    };
};