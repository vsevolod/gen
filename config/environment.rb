require 'litecable'
require 'anycable'

require_relative '../app'
require_relative '../game'

LiteCable.anycable!
Anycable.connection_factory = Game::Connection
