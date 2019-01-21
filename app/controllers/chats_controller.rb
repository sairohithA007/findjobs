class ChatsController < ApplicationController
  
  def save
    chat = Chat.new
    chatData = JSON.parse params[:chat]
    chat.recipient = chatData["receiver"] #params[:receiver]
    chat.content = chatData["content"] #params[:content]
    chat.postid = chatData["postid"] #params[:postid]
    chat.sender = current_user.id
    if chat.save
      data = 1 
    else
      data = 0  
    end
    render :json => data
  end
  
  
  def retrieve
    senderMessages = Chat.where(recipient: params[:receiver], sender: current_user.id, postid: params[:postid])
    recipientMessages = Chat.where(sender: params[:receiver], recipient: current_user.id, postid: params[:postid])
    data = Array.new
    data = (senderMessages + recipientMessages).sort_by(&:created_at)
=begin    
    senderCount = 0
    recipientCount = 0
    senderMessages.each do |senderMessage|
      recipientMessages.each do |recipientMessage|
        if senderMessage.created_at <= recipientMessage.created_at
          data.push(senderMessage)
          senderCount = senderCount + 1
          puts "Sender #{senderMessage.content}"
        else
          data.push(recipientMessage)
          recipientCount = recipientCount + 1
          puts "Receiver #{recipientMessage.content}"
        end
        break
      end
    end
    puts "SenderCount #{senderCount}"
    puts "ReceiverCount #{recipientCount}"
    while senderCount <= senderMessages.length
      puts "SenderCount #{senderCount}"
      data.push(senderMessages[senderCount])
      senderCount = senderCount + 1
    end
    while recipientCount <= recipientMessages.length
      puts "ReceiverCount #{recipientCount}"
      data.push(recipientMessages[recipientCount])
      recipientCount = recipientCount + 1
    end
=end
   # data.push(senderMessages)
   # data.push(recipientMessages)
    render :json => data
  end
  
  
end
