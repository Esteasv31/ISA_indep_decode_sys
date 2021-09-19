#include "em3d.h"
#include <cm/cmmd.h>
#include <fcntl.h>

#ifdef OLDEN
extern int __NumNodes;
#endif
extern int DebugFlag;

void filestuff()
{
  CMMD_fset_io_mode(stdout, CMMD_independent);
  fcntl(fileno(stdout), F_SETFL, O_APPEND);
  if (CMMD_self_address()) exit(0);
  __InitRegs(0);
}

void dealwithargs(int argc, char *argv[])
{

#ifdef OLDEN
  if (argc > 5)
    DebugFlag = atoi(argv[5]);
  else DebugFlag = 0;

  if (argc > 4)
    __NumNodes = atoi(argv[4]);    
  else
    __NumNodes = 4;
#endif

  if (argc > 1)
    n_nodes = atoi(argv[1]);
  else
    n_nodes = 64;

  if (argc > 2)
    d_nodes = atoi(argv[2]);
  else
    d_nodes = 3;

  if (argc > 3)
    local_p = atoi(argv[3]);
  else
    local_p = 75;
}
