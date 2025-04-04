SELECT DISTINCT
 T.TaskName AS MOVEit_TaskName
 ,TS_ToProcess.LogStamp AS MOVEit_LogStamp
 ,TS_ToProcess.SourceFilename AS MOVEit_SourceFilename
 ,TS_ToProcess.SourceFilenameOnly AS MOVEit_SourceFilenameOnly
 ,TS_ToProcess.DestFilename AS MOVEit_DestinationFilename
 ,TS_ToProcess.DestFilenameOnly AS MOVEit_DestinationFilenameOnly
 ,TS_ToProcess.ErrorCode AS MOVEit_ErrorCode
 ,TS_ToProcess.Message AS MOVEit_ErrorMessage
 FROM
 [MoveITMonitor].[dbo].[dimTask] AS T WITH(NOLOCK)
 LEFT OUTER JOIN
 [MoveITMonitor].[dbo].[factTaskStats] AS TS_ToProcess WITH(NOLOCK)
 ON
 T.TaskID=TS_ToProcess.TaskID AND TS_ToProcess.DirectionID = 4AND CONVERT(date, TS_ToProcess.NominalStartDatetime , 112) >= '20250404'
 AND CONVERT(date, TS_ToProcess.NominalStartDateTime, 112) <= '20250404'
 AND TS_ToProcess.DestFilename <> ''

WHERE
 T.taskname in
 (
	'FMS MPMD OB DLY AlderaExtract_PostPaymentClaims',
	'FMS LWWA OB DLY AlderaExtract_PostPaymentClaims',
	'FMS PMWA OB DLY AlderaExtract_PostPaymentClaims',
	'FMS PMAK OB DLY AlderaExtract_PostPaymentClaims',
	'FMS BRIF OB DLY AlderaExtract_PostPaymentClaims',
	'FMS BHAR OB DLY AlderaExtract_PostPaymentClaims',
	'FMS MABR OB DLY AlderaExtract_PostPaymentClaims',
	'FMS SMNY OB DLY AlderaExtract_PostPaymentClaims',
	'FMS CCHHS OB DLY AlderaExtract_PostPaymentClaims'
)
 AND T.Enabled = 1
AND T.ActiveRecord = 1
ORDER BY
 TS_ToProcess.LogStamp, TS_ToProcess.SourceFilenameOnly
