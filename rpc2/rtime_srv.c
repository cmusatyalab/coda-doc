#ifndef _BLURB_
#define _BLURB_
/*
                           CODA FILE SYSTEM
                      School of Computer Science
                      Carnegie Mellon University
                          Copyright 1987-92

Past and present contributors to Coda include M. Satyanarayanan, James
Kistler, Puneet Kumar, David  Steere,  Maria  Okasaki,  Lily  Mummert,
Ellen  Siegel,  Brian  Noble, Anders Klemets, Masashi Kudo, and Walter
Smith.  The use of Coda outside Carnegie Mellon University requires  a
license.  Contact the Coda project coordinator for licensing details.
*/


static char *rcsid = "$Header$";
#endif _BLURB_

#include <stdio.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <assert.h>
#include <sys/time.h>
#include "lwp.h"
#include "rpc2.h"
#include "rtime.h"


main()
{
  RPC2_Handle cid;
  RPC2_RequestFilter reqfilter;
  RPC2_PacketBuffer *reqbuffer;
  int rc;

  Init_RPC();

  reqfilter.FromWhom = ANY;
  reqfilter.OldOrNew = OLDORNEW;
  reqfilter.ConnOrSubsys.SubsysId = RTIMESUBSYSID;

  /* loop forever, wait for the client to call for service */
  for ( ; ; ) {
      rc = RPC2_GetRequest(&reqfilter, &cid, &reqbuffer, NULL, NULL, NULL) ;
      if (rc != RPC2_SUCCESS) 
	  fprintf(stderr, RPC2_ErrorMsg(rc));
      rc = rtime_ExecuteRequest(cid, reqbuffer);
      if (rc != RPC2_SUCCESS)
          fprintf(stderr, RPC2_ErrorMsg(rc));
  };
};

error_report(message)
char *message;
{
  fprintf(stderr, message);
  fprintf(stderr, "\n");
  exit(1);
}

Init_RPC()
{
  PROCESS mylpid;
  RPC2_PortalIdent pid, *pids;
  RPC2_SubsysIdent sid;
  int rc;
  char msg[100];

  /* Initialize LWP package */
  if (LWP_Init(LWP_VERSION, LWP_NORMAL_PRIORITY, &mylpid) != LWP_SUCCESS)
      error_report("Can't Initialize LWP") ;

  /* Initialize RPC2 package */
  pids = &pid;
  pid.Tag = RPC2_PORTALBYINETNUMBER;
  pid.Value.InetPortNumber = htons(RTIMEPORTAL);
  rc = RPC2_Init(RPC2_VERSION, NULL, &pids, 1, -1, NULL);
  if (rc != RPC2_SUCCESS) {
      sprintf(msg, "%s\nCan't Initialize RPC2", RPC2_ErrorMsg(rc));
      error_report(msg);
  };

  sid.Tag = RPC2_SUBSYSBYID;
  sid.Value.SubsysId = RTIMESUBSYSID;
  rc = RPC2_Export(&sid) != RPC2_SUCCESS ;
  if (rc != RPC2_SUCCESS) {
      sprintf(msg, "%s\nCan't export the rtime subsystem");
      error_report(msg);
  };
}

long GetRTime(_cid, tv_sec, tv_usec) 
RPC2_Handle _cid;
int *tv_sec;
int *tv_usec;
{
  struct timeval tp;
  struct timezone tzp;

  gettimeofday(&tp, &tzp);
  *tv_sec = tp.tv_sec;
  *tv_usec = tp.tv_usec; 
  return RPC2_SUCCESS;
}

