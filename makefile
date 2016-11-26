HASKELL_INCLUDE = -fno-common -U__PIC__ -D__PIC__ -Wimplicit -S '-D__GLASGOW_HASKELL__=710' -include /usr/local/lib/ghc-7.10.2/include/ghcversion.h -I/usr/local/lib/ghc-7.10.2/base_GDytRqRVSUX7zckgKqJjgw/include -I/usr/local/lib/ghc-7.10.2/integ_2aU3IZNMF9a7mQ0OzsZ0dS/include -I/usr/local/lib/ghc-7.10.2/include
HASKELL_LINK = -L/usr/local/lib/ghc-7.10.2/base_GDytRqRVSUX7zckgKqJjgw -L/usr/local/lib/ghc-7.10.2/integ_2aU3IZNMF9a7mQ0OzsZ0dS -L/usr/local/lib/ghc-7.10.2/ghcpr_8TmvWUcS1U1IKHT0levwg3 -L/usr/local/lib/ghc-7.10.2/rts -Wl,-u,_ghczmprim_GHCziTypes_Izh_static_info -Wl,-u,_ghczmprim_GHCziTypes_Czh_static_info -Wl,-u,_ghczmprim_GHCziTypes_Fzh_static_info -Wl,-u,_ghczmprim_GHCziTypes_Dzh_static_info -Wl,-u,_base_GHCziPtr_Ptr_static_info -Wl,-u,_ghczmprim_GHCziTypes_Wzh_static_info -Wl,-u,_base_GHCziInt_I8zh_static_info -Wl,-u,_base_GHCziInt_I16zh_static_info -Wl,-u,_base_GHCziInt_I32zh_static_info -Wl,-u,_base_GHCziInt_I64zh_static_info -Wl,-u,_base_GHCziWord_W8zh_static_info -Wl,-u,_base_GHCziWord_W16zh_static_info -Wl,-u,_base_GHCziWord_W32zh_static_info -Wl,-u,_base_GHCziWord_W64zh_static_info -Wl,-u,_base_GHCziStable_StablePtr_static_info -Wl,-u,_ghczmprim_GHCziTypes_Izh_con_info -Wl,-u,_ghczmprim_GHCziTypes_Czh_con_info -Wl,-u,_ghczmprim_GHCziTypes_Fzh_con_info -Wl,-u,_ghczmprim_GHCziTypes_Dzh_con_info -Wl,-u,_base_GHCziPtr_Ptr_con_info -Wl,-u,_base_GHCziPtr_FunPtr_con_info -Wl,-u,_base_GHCziStable_StablePtr_con_info -Wl,-u,_ghczmprim_GHCziTypes_False_closure -Wl,-u,_ghczmprim_GHCziTypes_True_closure -Wl,-u,_base_GHCziPack_unpackCString_closure -Wl,-u,_base_GHCziIOziException_stackOverflow_closure -Wl,-u,_base_GHCziIOziException_heapOverflow_closure -Wl,-u,_base_ControlziExceptionziBase_nonTermination_closure -Wl,-u,_base_GHCziIOziException_blockedIndefinitelyOnMVar_closure -Wl,-u,_base_GHCziIOziException_blockedIndefinitelyOnSTM_closure -Wl,-u,_base_GHCziIOziException_allocationLimitExceeded_closure -Wl,-u,_base_ControlziExceptionziBase_nestedAtomically_closure -Wl,-u,_base_GHCziEventziThread_blockedOnBadFD_closure -Wl,-u,_base_GHCziWeak_runFinalizzerBatch_closure -Wl,-u,_base_GHCziTopHandler_flushStdHandles_closure -Wl,-u,_base_GHCziTopHandler_runIO_closure -Wl,-u,_base_GHCziTopHandler_runNonIO_closure -Wl,-u,_base_GHCziConcziIO_ensureIOManagerIsRunning_closure -Wl,-u,_base_GHCziConcziIO_ioManagerCapabilitiesChanged_closure -Wl,-u,_base_GHCziConcziSync_runSparks_closure -Wl,-u,_base_GHCziConcziSignal_runHandlersPtr_closure -Wl,-search_paths_first -lHSbase-4.8.1.0-GDytRqRVSUX7zckgKqJjgw -lHSinteger-gmp-1.0.0.0-2aU3IZNMF9a7mQ0OzsZ0dS -lHSghc-prim-0.4.0.0-8TmvWUcS1U1IKHT0levwg3 -lHSrts -lCffi -liconv -lm -ldl -Wl,-no_compact_unwind

HaskellQuicksort: quicksort_stub
	gcc -O2 -m64 -x c HaskellQuicksort.c -o HaskellQuicksort.s $(HASKELL_INCLUDE)
	gcc -x assembler -c HaskellQuicksort.s -o HaskellQuicksort.o
	gcc HaskellQuicksort.o Quicksort.o -o HaskellQuicksort $(HASKELL_LINK)
quicksort_stub:
	ghc -c Quicksort.hs
    
AssemblyQuicksort.o:
	g++ -c AssemblyQuicksort.cpp -o AssemblyQuicksort.o
AssemblyQuicksort: AssemblyQuicksort.o
	ghc -O2 ForeignQuicksort.hs AssemblyQuicksort.o -o AssemblyQuicksort
	make clean
    
clean:
	rm *.o *.hi *.s *_stub.h
