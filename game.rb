module Game
   class Connection < LiteCable::Connection::Base
     identified_by :sid

     def connect
       @sid = request.params['sid']

       $stdout.puts "@#{@sid} connected!"
     end

     def disconnect
       $stdout.puts "@#{@sid} disconnected :("
     end
   end

   class Channel < LiteCable::Channel::Base
     NAME = 'main_channel'

     identifier :main

     def subscribed
       stream_from NAME
     end

     def tik(data)
       LiteCable.broadcast NAME, message: data
     end
   end
end
