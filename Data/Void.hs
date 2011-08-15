-----------------------------------------------------------------------------
-- |
-- Module      :  Data.Void
-- Copyright   :  (C) 2008-2011 Edward Kmett
-- License     :  BSD-style (see the file LICENSE)
--
-- Maintainer  :  Edward Kmett <ekmett@gmail.com>
-- Stability   :  provisional
-- Portability :  portable
--
----------------------------------------------------------------------------
module Data.Void (Void, absurd, vacuous) where

import Data.Semigroup (Semigroup(..))
import Data.Ix

#ifdef LANGUAGE_DeriveDataTypeable
import Data.Data
#endif

#ifdef __GLASGOW_HASKELL__
import Unsafe.Coerce
#endif

#if __GLASGOW_HASKELL__ < 700
data Void = Void !Void 
#else
newtype Void = Void Void
#endif
  deriving 
  ( Eq, Ord, Show, Read
#ifdef LANGUAGE_DeriveDataTypeable
  , Data, Typeable
#endif
  )

-- | Since Void values are logically uninhabited, this witnesses the logical
-- reasoning tool of 'ex falso quodlibet'.
absurd :: Void -> a
absurd (Void a) = absurd a

vacuous :: Functor f => f Void -> f a
#ifdef __GLASGOW_HASKELL__
vacuous = unsafeCoerce
#else
-- other haskell compilers are free to use less homogeneous representations
vacuous = fmap absurd
#endif

instance Semigroup Void where
  a <> _ = a
  times1p _ a = a

instance Ix Void where
  range _ = []
  index _ = absurd
  inRange _ = absurd
  rangeSize _ = 0 
