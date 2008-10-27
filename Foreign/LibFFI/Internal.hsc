{-# LANGUAGE ForeignFunctionInterface, EmptyDataDecls #-}
module Foreign.LibFFI.Internal where

#include <ffi.h>

import Data.Int
import Data.Word
import Foreign.C.Types
import Foreign.Ptr
import Foreign.Storable

data CValue
data CType
data CIF

type C_ffi_status   = (#type ffi_status)
type C_ffi_abi      = (#type ffi_abi)

ffi_default_abi :: C_ffi_abi
ffi_default_abi = #const FFI_DEFAULT_ABI

ffi_ok          :: C_ffi_status
ffi_ok          = #const FFI_OK

sizeOf_cif :: Int
sizeOf_cif = #size ffi_cif

foreign import ccall unsafe ffi_prep_cif
    :: Ptr CIF -> C_ffi_abi -> CUInt -> Ptr CType -> Ptr (Ptr CType) -> IO C_ffi_status

foreign import ccall unsafe ffi_call
    :: Ptr CIF -> FunPtr a -> Ptr CValue -> Ptr (Ptr CValue) -> IO ()
