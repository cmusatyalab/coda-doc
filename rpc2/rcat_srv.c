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
#include "lwp.h"
#include "rpc2.h"
#include "rcat.h"

main()
{
  RPC2_Handle the_connection;
  RPC2_RequestFilter reqfilter;
  RPC2_PacketBuffer *reqbuffer;
  int return_code;

  Init_RPC();

  reqfilter.FromWhom = ANY;
  reqfilter.OldOrNew = OLDORNEW;
  reqfilter.ConnOrSubsys.SubsysId = RCAT_SUBSYSID;

  /* loop forever, wait the client to call for service */
  while (1) {
      return_code = RPC2_GetRequest(&reqfilter, &the_connection, &reqbuffer, 
				    NULL, NULL, NULL);
      if (return_code != RPC2_SUCCESS) 
	  fprintf(stderr, RPC2_ErrorMsg(return_code));
      return_code = rcat_ExecuteRequest(the_connection, reqbuffer);
      if (return_code != RPC2_SUCCESS)
          fprintf(stderr, RPC2_ErrorMsg(return_code));
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
  PROCESS dummy;
  RPC2_PortalIdent pid, *pids;
  RPC2_SubsysIdent sid;
  SFTP_Initializer sftpi;
  int return_code ;
  char error_msg[100] ;

  if (LWP_Init(LWP_VERSION, LWP_NORMAL_PRIORITY, &dummy) != LWP_SUCCESS)
      error_report("Can't Initialize LWP");  /* Initialize LWP package */

  SFTP_SetDefaults(&sftpi);
  SFTP_Activate(&sftpi); /* Initialize side effects SFTP package */

  pids = &pid;
  pid.Tag = RPC2_PORTALBYINETNUMBER;
  pid.Value.InetPortNumber = htons(RCAT_PORTAL);
  return_code = RPC2_Init(RPC2_VERSION, NULL, &pids, 1, -1, NULL);
  /* Initialize RPC2 package */
  if (return_code != RPC2_SUCCESS) {
      sprintf(error_msg, "%s\nCan't Initialize RPC2", 
	      RPC2_ErrorMsg(return_code));
      error_report(error_msg); 
  };

  sid.Tag = RPC2_SUBSYSBYID;
  sid.Value.SubsysId = RCAT_SUBSYSID;
  return_code = RPC2_Export(&sid);
  if (return_code != RPC2_SUCCESS) {
      sprintf(error_msg, "%s\nCan't export the rcat subsystem",
	      RPC2_ErrorMsg(return_code));
      error_report(error_msg);
  };
}

long Fetch_Remote_File(_cid, filename)
RPC2_Handle _cid;
char *filename;
{
  SE_Descriptor sed;
  
  /* set the side effect descriptor to transfer the file */
  bzero(&sed, sizeof(sed));
  sed.Tag = SMARTFTP;
  sed.Value.SmartFTPD.Tag = FILEBYNAME;
  sed.Value.SmartFTPD.TransmissionDirection = SERVERTOCLIENT;
  sed.Value.SmartFTPD.ByteQuota = -1;
  strcpy(sed.Value.SmartFTPD.FileInfo.ByName.LocalFileName, filename);

  /* do the actual transfer */
  if (RPC2_InitSideEffect(_cid, &sed) != RPC2_SUCCESS)
      return(RCAT_FAILED);
  if (RPC2_CheckSideEffect(_cid, &sed, SE_AWAITLOCALSTATUS) != RPC2_SUCCESS)
      return(RCAT_FAILED);
  return RPC2_SUCCESS;
}

iopen() {}

