jQuery(document).on 'turbolinks:load', ->
  body = $('body')
  if body.data('user-id')
    App.global_user_chat = App.cable.subscriptions.create {
      channel: "UserChannel"
      chat_user_id: body.data('user-id')
    },
      connected: ->
# Called when the subscription is ready for use on the server

      disconnected: ->
# Called when the subscription has been terminated by the server

      received: (data) ->
        if $('#messages').data('user-to') != $(data['message']).data('user-id')
          toastr.success(data['message'], '<a href="/chat_rooms/create_or_find?user_id='+ $(data['message']).data('user-id')+ '" >' + $(data['message']).data('owner') + '</a> Says')
