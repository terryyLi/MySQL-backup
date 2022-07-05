#!/bin/bash
# Carnegie Mellon University, Human Computer Interaction Institute.
# Copyright 2022. All Rights Reserved.
# Author: Terry Li



# MYSQL_HOST - just the FQDN, e.g. your.domain.name.edu
MYSQL_USER=<changeme>       # MySQL User
MYSQL_PASSWORD=<changeme> # MySQL Password
MYSQL_DAYS_TO_KEEP=<changeme>    # 0 to keep forever
MYSQL_GZIP=<changeme>            # 1 = Compress
MYSQL_BACKUP_PATH=<changeme>
MYSQL_OPT=<changeme>

# Log directories
BASE_LOG=${BASE}/log
FFI_LOG=${BASE_LOG}/ffi_log
FILELOADER_LOG=${BASE_LOG}/fileloader_log
CONVERSION_LOG=${BASE_LOG}/log_conversion
ANT_LOG=${BASE_LOG}/ant
MSG_REPORT_LOG=${BASE_LOG}/msg_report
USER_ROLE_REPORT_LOG=${BASE_LOG}/user_role_report
SCRIPTS_LOG=${BASE_LOG}/scripts

# Stored Procedures
SP_DIR=${BASE}/sql/sps_and_triggers
SP_PL2_DIR=${BASE}/pl2sql/sps_and_triggers
