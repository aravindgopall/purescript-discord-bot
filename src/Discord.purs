module Control.Discord where

import Type.Data.Boolean

import Data.Either (Either(..))
import Effect (Effect)
import Effect.Aff (Aff, makeAff, nonCanceler)
import Effect.Class (liftEffect)
import Prelude (Unit, pure, ($), (*>), (>>>))

foreign import data Discord :: Type
foreign import data Client :: Type
foreign import data Message :: Type


data DString (sym :: Symbol) = String
data DBoolean (sym :: Boolean) = Boolean

type ClientOptions = 
  { apiRequestMethod :: String 
  , fetchAllMembers :: Boolean
  , shardId :: Int
  }

type ClientUser = 
  { avatar :: String
  , avatarURL :: String
  , bot :: Boolean
  , client :: Client
  , lastMessage :: Message
  , blocked :: Boolean
  , email :: String
  , verified :: String
  }

foreign import getClient :: ClientOptions -> Effect Client   
foreign import _updateToken :: String -> Client -> Effect Unit
foreign import _onMessage :: Client -> (Message -> Effect Unit) -> Effect Message 
foreign import onReady :: Client -> (Unit -> Effect Unit) -> Effect Unit
{-- foreign import _getMessage :: Client -> Message --}


onMessage :: Client -> Aff Message
onMessage client = makeAff (\cb -> _onMessage client (Right >>> cb) *> pure nonCanceler)

updateToken :: String -> Client -> Effect Unit
updateToken key client = _updateToken key client
