import consumer from "./consumer"

$(document).on('turbolinks:load', function () {
    consumer.subscriptions.create("QuestionsChannel", {
        connected() {},

        disconnected() {
        },

        received(data) {
            $('.questions').prepend(data)
            $('.flash').html('<div class="alert alert-success" <span> Question successfully created! </span> </div>');
        }
    });
});
