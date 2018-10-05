module Main where

import Prelude

import Control.Discord (ClientOptions, getClient, onReady, updateToken)
import Effect (Effect)
import Effect.Console (log)
import Type.Data.Boolean (False)

main :: Effect Unit
main = do
  client <- getClient defaultClientOptions
  updateToken "" client
  onReady client (\_ -> log "Hello dude") 
  log "Hello sailor!"


defaultClientOptions :: ClientOptions
defaultClientOptions = 
  { apiRequestMethod : "sequential"
  , fetchAllMembers : false
  , shardId : 0
  }
