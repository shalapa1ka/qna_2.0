import consumer from "./consumer"

$(document).on('turbolinks:load', function () {

    const element = $('#question-id')
    const question_id = element.attr('data-question-id')

    consumer.subscriptions.subscriptions.forEach((subscription) => {
      consumer.subscriptions.remove(subscription)
    })

    consumer.subscriptions.create({channel: "QuestionChannel", question_id: question_id}, {
        connected() {},

        disconnected() {},

        received(data) {
            $('.answers').prepend(data)
            console.log('123')
        }
    });
})
