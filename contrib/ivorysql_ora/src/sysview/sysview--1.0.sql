/* 
 * function which converts all-uppercase text to all-lowercase text
 * and vice versa. 
 */
CREATE OR REPLACE FUNCTION SYS.ORA_CASE_TRANS(VARCHAR2)
RETURNS VARCHAR2
AS 'MODULE_PATHNAME','ora_case_trans'
LANGUAGE C IMMUTABLE;

/* DBA_PROCEDURES */
CREATE OR REPLACE VIEW SYS.DBA_PROCEDURES AS
	SELECT
		SYS.ORA_CASE_TRANS(
			PG_GET_USERBYID(P.PROOWNER)::VARCHAR2
		)::VARCHAR2(128) AS OWNER,
		SYS.ORA_CASE_TRANS(P.PRONAME::VARCHAR2)::VARCHAR2(128) AS OBJECT_NAME,
		NULL::VARCHAR2(128) AS PROCEDURE_NAME,
		P.OID::VARCHAR2(10)::NUMBER AS OBJECT_ID,
		1::NUMBER AS SUBPROGRAM_ID,
		NULL::VARCHAR2(40) AS OVERLOAD,
		CASE
			WHEN P.PROKIND = 'p'
				THEN 'PROCEDURE'
			WHEN P.PROKIND = 'f'
				THEN 'FUNCTION'
			ELSE NULL
		END::VARCHAR2(13) AS OBJECT_TYPE,
		CASE
			WHEN P.PROKIND = 'a'
				THEN 'YES'
			ELSE 'NO'
		END::VARCHAR2(3) AS AGGREGATE,
		'NO'::VARCHAR2(3) AS PIPELINED,
		NULL::VARCHAR2(128) AS IMPLTYPOWNER,
		NULL::VARCHAR2(128) AS IMPLTYPNAME,
		CASE
			WHEN P.PROPARALLEL = 'u'
				THEN 'NO'
			ELSE 'YES'
		END::VARCHAR2(3) AS PARALLEL,
		'NO'::VARCHAR2(3) AS INTERFACE,
		CASE
			WHEN P.PROVOLATILE = 'i'
				THEN 'YES'
			ELSE 'NO'
		END::VARCHAR2(3) AS DETERMINISTIC,
		CASE
			WHEN P.PROSECDEF = 't'
				THEN 'DEFINER'
			ELSE 'CURRENT_USER'
		END::VARCHAR2(12) AS AUTHID,
		'NO'::VARCHAR2(3) AS RESULT_CACHE,
		0::VARCHAR2(256) AS ORIGIN_CON_ID,
		'NULL'::VARCHAR2(5) AS POLYMORPHIC,
		'NULL'::VARCHAR2(6) AS SQL_MACRO,
		NULL::VARCHAR2(3) AS BLOCKCHAIN,
		NULL::VARCHAR2(4000) AS BLOCKCHAIN_MANDATORY_VOTES
	FROM
		PG_PROC AS P
		LEFT JOIN PG_TRIGGER AS T
			ON P.OID = T.TGFOID
	WHERE
		T.OID IS NULL
		AND P.PRONAMESPACE != 'PG_CATALOG'::REGNAMESPACE::OID
		AND P.PRONAMESPACE != 'PG_TOAST'::REGNAMESPACE::OID
		AND P.PRONAMESPACE != 'INFORMATION_SCHEMA'::REGNAMESPACE::OID
UNION ALL
	SELECT
		SYS.ORA_CASE_TRANS(
			PG_GET_USERBYID(P.PROOWNER)::VARCHAR2
		)::VARCHAR2(128) AS OWNER,
		SYS.ORA_CASE_TRANS(T.TGNAME::VARCHAR2)::VARCHAR2(128) AS OBJECT_NAME,
		NULL::VARCHAR2(128) AS PROCEDURE_NAME,
		T.OID::VARCHAR2(10)::NUMBER AS OBJECT_ID,
		1::NUMBER AS SUBPROGRAM_ID,
		NULL::VARCHAR2(40) AS OVERLOAD,
		'TRIGGER'::VARCHAR2(13) AS OBJECT_TYPE,
		'NO'::VARCHAR2(3) AS AGGREGATE,
		'NO'::VARCHAR2(3) AS PIPELINED,
		NULL::VARCHAR2(128) AS IMPLTYPOWNER,
		NULL::VARCHAR2(128) AS IMPLTYPNAME,
		'NO'::VARCHAR2(3) AS PARALLEL,
		'NO'::VARCHAR2(3) AS INTERFACE,
		'NO'::VARCHAR2(3) AS DETERMINISTIC,
		'DEFINER'::VARCHAR2(12) AS AUTHID,
		'NO'::VARCHAR2(3) AS RESULT_CACHE,
		0::VARCHAR2(256) AS ORIGIN_CON_ID,
		NULL::VARCHAR2(5) AS POLYMORPHIC,
		NULL::VARCHAR2(6) AS SQL_MACRO,
		NULL::VARCHAR2(3) AS BLOCKCHAIN,
		NULL::VARCHAR2(4000) AS BLOCKCHAIN_MANDATORY_VOTES
	FROM
		PG_TRIGGER AS T
		LEFT JOIN PG_PROC AS P
			ON T.TGFOID = P.OID
	WHERE
		P.PRONAMESPACE != 'PG_CATALOG'::REGNAMESPACE::OID
		AND P.PRONAMESPACE != 'PG_TOAST'::REGNAMESPACE::OID
		AND P.PRONAMESPACE != 'INFORMATION_SCHEMA'::REGNAMESPACE::OID
ORDER BY
	OWNER, OBJECT_ID
;

/* GRANT SELECT PRIVILEGE TO PUBLIC */
GRANT SELECT ON SYS.DBA_PROCEDURES TO PUBLIC;

/* ALL_PROCEDURES */
CREATE OR REPLACE VIEW SYS.ALL_PROCEDURES AS
	SELECT
		SYS.ORA_CASE_TRANS(
			PG_GET_USERBYID(P.PROOWNER)::VARCHAR2
		)::VARCHAR2(128) AS OWNER,
		SYS.ORA_CASE_TRANS(P.PRONAME::VARCHAR2)::VARCHAR2(128) AS OBJECT_NAME,
		NULL::VARCHAR2(128) AS PROCEDURE_NAME,
		P.OID::VARCHAR2(10)::NUMBER AS OBJECT_ID,
		1::NUMBER AS SUBPROGRAM_ID,
		NULL::VARCHAR2(40) AS OVERLOAD,
		CASE
			WHEN P.PROKIND = 'p'
				THEN 'PROCEDURE'
			WHEN P.PROKIND = 'f'
				THEN 'FUNCTION'
			ELSE NULL
		END::VARCHAR2(13) AS OBJECT_TYPE,
		CASE
			WHEN P.PROKIND = 'a'
				THEN 'YES'
			ELSE 'NO'
		END::VARCHAR2(3) AS AGGREGATE,
		'NO'::VARCHAR2(3) AS PIPELINED,
		NULL::VARCHAR2(128) AS IMPLTYPOWNER,
		NULL::VARCHAR2(128) AS IMPLTYPNAME,
		CASE
			WHEN P.PROPARALLEL = 'u'
				THEN 'NO'
			ELSE 'YES'
		END::VARCHAR2(3) AS PARALLEL,
		'NO'::VARCHAR2(3) AS INTERFACE,
		CASE
			WHEN P.PROVOLATILE = 'i'
				THEN 'YES'
			ELSE 'NO'
		END::VARCHAR2(3) AS DETERMINISTIC,
		CASE
			WHEN P.PROSECDEF = 't'
				THEN 'DEFINER'
			ELSE 'CURRENT_USER'
		END::VARCHAR2(12) AS AUTHID,
		'NO'::VARCHAR2(3) AS RESULT_CACHE,
		0::VARCHAR2(256) AS ORIGIN_CON_ID,
		'NULL'::VARCHAR2(5) AS POLYMORPHIC,
		'NULL'::VARCHAR2(6) AS SQL_MACRO,
		NULL::VARCHAR2(3) AS BLOCKCHAIN,
		NULL::VARCHAR2(4000) AS BLOCKCHAIN_MANDATORY_VOTES
	FROM
		PG_PROC AS P
		LEFT JOIN PG_TRIGGER AS T
			ON P.OID = T.TGFOID
	WHERE
		T.OID IS NULL
		AND P.PRONAMESPACE != 'PG_CATALOG'::REGNAMESPACE::OID
		AND P.PRONAMESPACE != 'PG_TOAST'::REGNAMESPACE::OID
		AND P.PRONAMESPACE != 'INFORMATION_SCHEMA'::REGNAMESPACE::OID
		AND HAS_SCHEMA_PRIVILEGE(P.PRONAMESPACE, 'USAGE')
		AND HAS_FUNCTION_PRIVILEGE(P.OID, 'EXECUTE')
UNION ALL
	SELECT
		SYS.ORA_CASE_TRANS(
			PG_GET_USERBYID(P.PROOWNER)::VARCHAR2
		)::VARCHAR2(128) AS OWNER,
		SYS.ORA_CASE_TRANS(T.TGNAME::VARCHAR2)::VARCHAR2(128) AS OBJECT_NAME,
		NULL::VARCHAR2(128) AS PROCEDURE_NAME,
		T.OID::VARCHAR2(10)::NUMBER AS OBJECT_ID,
		1::NUMBER AS SUBPROGRAM_ID,
		NULL::VARCHAR2(40) AS OVERLOAD,
		'TRIGGER'::VARCHAR2(13) AS OBJECT_TYPE,
		'NO'::VARCHAR2(3) AS AGGREGATE,
		'NO'::VARCHAR2(3) AS PIPELINED,
		NULL::VARCHAR2(128) AS IMPLTYPOWNER,
		NULL::VARCHAR2(128) AS IMPLTYPNAME,
		'NO'::VARCHAR2(3) AS PARALLEL,
		'NO'::VARCHAR2(3) AS INTERFACE,
		'NO'::VARCHAR2(3) AS DETERMINISTIC,
		'DEFINER'::VARCHAR2(12) AS AUTHID,
		'NO'::VARCHAR2(3) AS RESULT_CACHE,
		0::VARCHAR2(256) AS ORIGIN_CON_ID,
		NULL::VARCHAR2(5) AS POLYMORPHIC,
		NULL::VARCHAR2(6) AS SQL_MACRO,
		NULL::VARCHAR2(3) AS BLOCKCHAIN,
		NULL::VARCHAR2(4000) AS BLOCKCHAIN_MANDATORY_VOTES
	FROM
		PG_TRIGGER AS T
		LEFT JOIN PG_PROC AS P
			ON T.TGFOID = P.OID
	WHERE
		P.PRONAMESPACE != 'PG_CATALOG'::REGNAMESPACE::OID
		AND P.PRONAMESPACE != 'PG_TOAST'::REGNAMESPACE::OID
		AND P.PRONAMESPACE != 'INFORMATION_SCHEMA'::REGNAMESPACE::OID
		AND HAS_SCHEMA_PRIVILEGE(P.PRONAMESPACE, 'USAGE')
		AND HAS_FUNCTION_PRIVILEGE(T.TGFOID, 'EXECUTE')
ORDER BY
	OWNER, OBJECT_ID
;

/* GRANT SELECT PRIVILEGE TO PUBLIC */
GRANT SELECT ON SYS.ALL_PROCEDURES TO PUBLIC;

/* USER_PROCEDURES */
CREATE OR REPLACE VIEW SYS.USER_PROCEDURES AS
	SELECT
		SYS.ORA_CASE_TRANS(P.PRONAME::VARCHAR2)::VARCHAR2(128) AS OBJECT_NAME,
		NULL::VARCHAR2(128) AS PROCEDURE_NAME,
		P.OID::VARCHAR2(10)::NUMBER AS OBJECT_ID,
		1::NUMBER AS SUBPROGRAM_ID,
		NULL::VARCHAR2(40) AS OVERLOAD,
		CASE
			WHEN P.PROKIND = 'p'
				THEN 'PROCEDURE'
			WHEN P.PROKIND = 'f'
				THEN 'FUNCTION'
			ELSE NULL
		END::VARCHAR2(13) AS OBJECT_TYPE,
		CASE
			WHEN P.PROKIND = 'a'
				THEN 'YES'
			ELSE 'NO'
		END::VARCHAR2(3) AS AGGREGATE,
		'NO'::VARCHAR2(3) AS PIPELINED,
		NULL::VARCHAR2(128) AS IMPLTYPOWNER,
		NULL::VARCHAR2(128) AS IMPLTYPNAME,
		CASE
			WHEN P.PROPARALLEL = 'u'
				THEN 'NO'
			ELSE 'YES'
		END::VARCHAR2(3) AS PARALLEL,
		'NO'::VARCHAR2(3) AS INTERFACE,
		CASE
			WHEN P.PROVOLATILE = 'i'
				THEN 'YES'
			ELSE 'NO'
		END::VARCHAR2(3) AS DETERMINISTIC,
		CASE
			WHEN P.PROSECDEF = 't'
				THEN 'DEFINER'
			ELSE 'CURRENT_USER'
		END::VARCHAR2(12) AS AUTHID,
		'NO'::VARCHAR2(3) AS RESULT_CACHE,
		0::VARCHAR2(256) AS ORIGIN_CON_ID,
		'NULL'::VARCHAR2(5) AS POLYMORPHIC,
		'NULL'::VARCHAR2(6) AS SQL_MACRO,
		NULL::VARCHAR2(3) AS BLOCKCHAIN,
		NULL::VARCHAR2(4000) AS BLOCKCHAIN_MANDATORY_VOTES
	FROM
		PG_PROC AS P
	LEFT JOIN PG_TRIGGER AS T
		ON P.OID = T.TGFOID
	WHERE
		T.OID IS NULL
		AND P.PRONAMESPACE != 'PG_CATALOG'::REGNAMESPACE::OID
		AND P.PRONAMESPACE != 'PG_TOAST'::REGNAMESPACE::OID
		AND P.PRONAMESPACE != 'INFORMATION_SCHEMA'::REGNAMESPACE::OID
		AND P.PROOWNER::REGROLE = CURRENT_USER::REGROLE
UNION ALL
	SELECT
		SYS.ORA_CASE_TRANS(T.TGNAME::VARCHAR2)::VARCHAR2(128) AS OBJECT_NAME,
		NULL::VARCHAR2(128) AS PROCEDURE_NAME,
		T.OID::VARCHAR2(10)::NUMBER AS OBJECT_ID,
		1::NUMBER AS SUBPROGRAM_ID,
		NULL::VARCHAR2(40) AS OVERLOAD,
		'TRIGGER'::VARCHAR2(13) AS OBJECT_TYPE,
		'NO'::VARCHAR2(3) AS AGGREGATE,
		'NO'::VARCHAR2(3) AS PIPELINED,
		NULL::VARCHAR2(128) AS IMPLTYPOWNER,
		NULL::VARCHAR2(128) AS IMPLTYPNAME,
		'NO'::VARCHAR2(3) AS PARALLEL,
		'NO'::VARCHAR2(3) AS INTERFACE,
		'NO'::VARCHAR2(3) AS DETERMINISTIC,
		'DEFINER'::VARCHAR2(12) AS AUTHID,
		'NO'::VARCHAR2(3) AS RESULT_CACHE,
		0::VARCHAR2(256) AS ORIGIN_CON_ID,
		NULL::VARCHAR2(5) AS POLYMORPHIC,
		NULL::VARCHAR2(6) AS SQL_MACRO,
		NULL::VARCHAR2(3) AS BLOCKCHAIN,
		NULL::VARCHAR2(4000) AS BLOCKCHAIN_MANDATORY_VOTES
	FROM
		PG_TRIGGER AS T
		LEFT JOIN PG_PROC AS P
			ON T.TGFOID = P.OID
	WHERE
		P.PRONAMESPACE != 'PG_CATALOG'::REGNAMESPACE::OID
		AND P.PRONAMESPACE != 'PG_TOAST'::REGNAMESPACE::OID
		AND P.PRONAMESPACE != 'INFORMATION_SCHEMA'::REGNAMESPACE::OID
		AND P.PROOWNER::REGROLE = CURRENT_USER::REGROLE
ORDER BY
	OBJECT_ID
;

/* GRANT SELECT PRIVILEGE TO PUBLIC */
GRANT SELECT ON SYS.USER_PROCEDURES TO PUBLIC;

/* PROSRC LINES COUNT */
CREATE OR REPLACE FUNCTION SYS._ORA_SRC_COUNT(PROID OID)
RETURNS INTEGER AS $$
DECLARE
	RET INTEGER;
BEGIN
	SELECT
		COUNT(1)
	FROM
	(
		SELECT
			UNNEST(STRING_TO_ARRAY(PROSRC, CHR(10)))
		FROM
			PG_PROC
		WHERE
			OID = $1
	) AS SQ
	INTO RET;
	RETURN RET;
END;
$$ LANGUAGE PLPGSQL IMMUTABLE;

/* DBA_SOURCE */
CREATE OR REPLACE VIEW SYS.DBA_SOURCE AS
SELECT
	SYS.ORA_CASE_TRANS(
		PG_GET_USERBYID(P.PROOWNER)::VARCHAR2
	)::VARCHAR2(128) AS OWNER,
	SYS.ORA_CASE_TRANS(P.PRONAME::VARCHAR2)::VARCHAR2(128) AS NAME,
	CASE
		WHEN P.PROKIND = 'f'
			THEN 'FUNCTION'
		ELSE 'PROCEDURE'
	END::VARCHAR2(12) AS TYPE,
	GENERATE_SERIES(1::INTEGER, SYS._ORA_SRC_COUNT(P.OID))::NUMBER AS LINE,
	UNNEST(STRING_TO_ARRAY(P.PROSRC, CHR(10)))::VARCHAR2(4000) AS TEXT,
	0::VARCHAR2(256) AS ORIGIN_CON_ID
FROM
	PG_PROC AS P
	LEFT JOIN PG_TRIGGER AS T
		ON P.OID = T.TGFOID
WHERE
	P.PROKIND = ANY(ARRAY['p', 'f'])
	AND T.OID IS NULL
	AND P.PRONAMESPACE <> 'PG_CATALOG'::REGNAMESPACE::OID
	AND P.PRONAMESPACE <> 'PG_TOAST'::REGNAMESPACE::OID
	AND P.PRONAMESPACE <> 'INFORMATION_SCHEMA'::REGNAMESPACE::OID
;

/* GRANT SELECT PRIVILEGE TO PUBLIC */
GRANT SELECT ON SYS.DBA_SOURCE TO PUBLIC;

/* ALL_SOURCE */
CREATE OR REPLACE VIEW SYS.ALL_SOURCE AS
SELECT
	SYS.ORA_CASE_TRANS(
		PG_GET_USERBYID(P.PROOWNER)::VARCHAR2
	)::VARCHAR2(128) AS OWNER,
	SYS.ORA_CASE_TRANS(P.PRONAME::VARCHAR2)::VARCHAR2(128) AS NAME,
	CASE
		WHEN P.PROKIND = 'f'
			THEN 'FUNCTION'
		ELSE 'PROCEDURE'
	END::VARCHAR2(12) AS TYPE,
	GENERATE_SERIES(1::INTEGER, SYS._ORA_SRC_COUNT(P.OID))::NUMBER AS LINE,
	UNNEST(STRING_TO_ARRAY(P.PROSRC, CHR(10)))::VARCHAR2(4000) AS TEXT,
	0::VARCHAR2(256) AS ORIGIN_CON_ID
FROM
	PG_PROC AS P
	LEFT JOIN PG_TRIGGER AS T
		ON P.OID = T.TGFOID
WHERE
	P.PROKIND = ANY(ARRAY['p', 'f'])
	AND T.OID IS NULL
	AND P.PRONAMESPACE <> 'PG_CATALOG'::REGNAMESPACE::OID
	AND P.PRONAMESPACE <> 'PG_TOAST'::REGNAMESPACE::OID
	AND P.PRONAMESPACE <> 'INFORMATION_SCHEMA'::REGNAMESPACE::OID
	AND HAS_SCHEMA_PRIVILEGE(P.PRONAMESPACE, 'USAGE')
	AND HAS_FUNCTION_PRIVILEGE(P.OID, 'EXECUTE')
;

/* GRANT SELECT PRIVILEGE TO PUBLIC */
GRANT SELECT ON SYS.ALL_SOURCE TO PUBLIC;

/* USER_SOURCE */
CREATE OR REPLACE VIEW SYS.USER_SOURCE AS
SELECT
	SYS.ORA_CASE_TRANS(P.PRONAME::VARCHAR2)::VARCHAR2(128) AS NAME,
	CASE
		WHEN P.PROKIND = 'f'
			THEN 'FUNCTION'
		ELSE 'PROCEDURE'
	END::VARCHAR2(12) AS TYPE,
	GENERATE_SERIES(1::INTEGER, SYS._ORA_SRC_COUNT(P.OID))::NUMBER AS LINE,
	UNNEST(STRING_TO_ARRAY(P.PROSRC, CHR(10)))::VARCHAR2(4000) AS TEXT,
	0::VARCHAR2(256) AS ORIGIN_CON_ID
FROM
	PG_PROC AS P
	LEFT JOIN PG_TRIGGER AS T
		ON P.OID = T.TGFOID
WHERE
	P.PROKIND = ANY(ARRAY['p', 'f'])
	AND T.OID IS NULL
	AND P.PRONAMESPACE <> 'PG_CATALOG'::REGNAMESPACE::OID
	AND P.PRONAMESPACE <> 'PG_TOAST'::REGNAMESPACE::OID
	AND P.PRONAMESPACE <> 'INFORMATION_SCHEMA'::REGNAMESPACE::OID
	AND P.PROOWNER::REGROLE = CURRENT_USER::REGROLE
;

/* GRANT SELECT PRIVILEGE TO PUBLIC */
GRANT SELECT ON SYS.USER_SOURCE TO PUBLIC;

/* ARGUMENTS' TYPE COUNT */
CREATE OR REPLACE FUNCTION SYS._ORA_ARGS_COUNT(PROID OID)
RETURNS INTEGER
AS $$
DECLARE
	RET INTEGER;
BEGIN
	SELECT
		COUNT(1)
	FROM
	(
		SELECT
			UNNEST(
				CASE
					WHEN PROALLARGTYPES IS NOT NULL
						THEN PROALLARGTYPES
					ELSE PROARGTYPES
				END
			)
		FROM
			PG_PROC
		WHERE OID = $1
	) AS SQ
	INTO
		RET;
	RETURN RET;
END;
$$ LANGUAGE PLPGSQL IMMUTABLE;

/* DBA_ARGUMENTS */
CREATE OR REPLACE VIEW SYS.DBA_ARGUMENTS AS
SELECT
	SYS.ORA_CASE_TRANS(
		PG_GET_USERBYID(P.PROOWNER)::VARCHAR2
	)::VARCHAR2(128) AS OWNER,
	SYS.ORA_CASE_TRANS(P.PRONAME::VARCHAR2)::VARCHAR2(128) AS OBJECT_NAME,
	NULL::VARCHAR2(128) AS PACKAGE_NAME,
	P.OID::VARCHAR2(10)::NUMBER AS OBJECT_ID,
	NULL::VARCHAR2(40) AS OVERLOAD,
	1::NUMBER AS SUBPROGRAM_ID,
	SYS.ORA_CASE_TRANS(
		SQ.ARGUMENT_NAME::VARCHAR2
	)::VARCHAR2(128) AS ARGUMENT_NAME,
	SQ.POSITION::NUMBER AS POSITION,
	CASE
		WHEN P.PROKIND = 'f'
			THEN SQ.POSITION + 1
		ELSE SQ.POSITION
	END::NUMBER AS SEQUENCE,
	0::NUMBER AS DATA_LEVEL,
	CASE
		WHEN T.TYPNAME = ANY(ARRAY['int2', 'int4', 'int8',
								   'numeric', 'number'])
			THEN 'NUMBER'
		WHEN T.TYPNAME = ANY(ARRAY['float4', 'float8'])
			THEN 'FLOAT'
		WHEN T.TYPNAME = 'bpchar'
			THEN 'CHAR'
		ELSE ORA_CASE_TRANS(T.OID::REGTYPE::VARCHAR2)::VARCHAR2(58)
	END::VARCHAR2(30) AS DATA_TYPE,
	CASE
		WHEN P.PRONARGDEFAULTS > 0
			AND SQ.POSITION > (_ORA_ARGS_COUNT(P.OID) - P.PRONARGDEFAULTS)
			THEN 'Y'
		ELSE 'N'
	END::VARCHAR2(1) AS DEFAULTED,
	NULL::LONG AS DEFAULT_VALUE,
	NULL::NUMBER AS DEFAULT_LENGTH,
	CASE
		WHEN SQ.IN_OUT = 'i' OR SQ.IN_OUT IS NULL
			THEN 'IN'
		WHEN SQ.IN_OUT = 'o'
			THEN 'OUT'
		WHEN SQ.IN_OUT = 'b'
			THEN 'IN/OUT'
		ELSE NULL
	END::VARCHAR2(9) AS IN_OUT,
	CASE
		WHEN T.TYPNAME = ANY(ARRAY['int2', 'int4', 'int8',
								   'float4', 'float8',
								   'numeric', 'number'])
			THEN 22
		WHEN T.TYPNAME = ANY(ARRAY['long', 'long_raw'])
			THEN 32760
		ELSE NULL
	END::NUMBER AS DATA_LENGTH,
	CASE
		WHEN T.TYPNAME = ANY(ARRAY['int2', 'int4', 'int8'])
			THEN 38
		WHEN T.TYPNAME = 'float4'
			THEN 63
		WHEN T.TYPNAME = 'float8'
			THEN 126
		WHEN T.TYPNAME = ANY(ARRAY['timestamp', 'timestamptz',
								   'oratimestamp', 'oratimestamptz',
								   'oratimestampltz'])
			THEN 6
		ELSE NULL
	END::NUMBER AS DATA_PRECISION,
	CASE
		WHEN T.TYPNAME = ANY(ARRAY['float4', 'float8'])
			THEN -127
		ELSE NULL
	END::NUMBER AS DATA_SCALE,
	CASE
		WHEN T.TYPNAME = ANY(ARRAY['numeric', 'number',
								   'int2', 'int4', 'int8',
								   'float4', 'float8'])
			THEN 10
		ELSE NULL
	END::NUMBER AS RADIX,
	CASE
		WHEN T.OID::REGTYPE::VARCHAR2(58) = ANY(ARRAY['char',
													  'character',
													  'varchar2',
													  'clob'])
			THEN 'CHAR_CS'
		WHEN T.OID::REGTYPE::VARCHAR2(58) = ANY(ARRAY['nchar', 'nvarchar2',
													  'nclob'])
			THEN 'NCHAR_CS'
	END::VARCHAR2(44) AS CHARACTER_SET_NAME,
	NULL::VARCHAR2(128) AS TYPE_OWNER,
	NULL::VARCHAR2(128) AS TYPE_NAME,
	NULL::VARCHAR2(128) AS TYPE_SUBNAME,
	NULL::VARCHAR2(128) AS TYPE_LINK,
	NULL::VARCHAR2(128) AS TYPE_OBJECT_TYPE,
	CASE
		WHEN T.TYPTYPE = 'b'
			THEN SYS.ORA_CASE_TRANS(T.OID::REGTYPE::VARCHAR2)
		WHEN T.TYPTYPE = 'd' AND T.TYPNAME = 'raw'
			THEN 'RAW'
		WHEN T.TYPTYPE = 'd' AND T.TYPNAME = 'blob'
			THEN 'BLOB'
		WHEN T.TYPTYPE = 'd' AND T.TYPNAME = 'clob'
			THEN 'CLOB'
		WHEN T.TYPTYPE = 'd' AND T.TYPNAME = 'nclob'
			THEN 'CLOB'
		WHEN T.TYPTYPE = 'd' AND T.TYPNAME = 'long'
			THEN 'LONG'
		WHEN T.TYPTYPE = 'd' AND T.TYPNAME = 'long_raw'
			THEN 'LONG_RAW'
		ELSE NULL
	END::VARCHAR2(30) AS PLS_TYPE,
	CASE
		WHEN T.OID::REGTYPE::VARCHAR2(58) = ANY(ARRAY['char',
													  'character',
													  'varchar2'])
			THEN NULL
		ELSE 0
	END::NUMBER AS CHAR_LENGTH,
	CASE
		WHEN T.OID::REGTYPE::VARCHAR2(58) = ANY(ARRAY['char',
													  'character',
													  'varchar2'])
			THEN 'B'
		ELSE '0'
	END::VARCHAR2(1) AS CHAR_USED,
	0::VARCHAR2(256) AS ORIGIN_CON_ID
FROM
	PG_PROC AS P
	LEFT JOIN
	(
		SELECT
			OID,
			NULL AS ARGUMENT_NAME,
			PRORETTYPE AS DATA_TYPE,
			'o' AS IN_OUT,
			0 AS POSITION
		FROM
			PG_PROC
		WHERE
			PROKIND = 'f'
		UNION ALL
		SELECT
			OID,
			UNNEST(PROARGNAMES) AS ARGUMENT_NAME,
			UNNEST(
			CASE
				WHEN PROALLARGTYPES IS NOT NULL
					THEN PROALLARGTYPES
				ELSE PROARGTYPES
			END) AS DATA_TYPE,
			UNNEST(PROARGMODES) AS IN_OUT,
			GENERATE_SERIES(1, SYS._ORA_ARGS_COUNT(OID)) AS POSITION
		FROM
			PG_PROC
	) AS SQ
		ON P.OID = SQ.OID
	LEFT JOIN PG_TYPE AS T
		ON SQ.DATA_TYPE = T.OID
	LEFT JOIN PG_TRIGGER AS TR
		ON P.OID = TR.TGFOID
WHERE
	TR.OID IS NULL 
	AND P.PRONAMESPACE <> 'PG_CATALOG'::REGNAMESPACE::OID
	AND P.PRONAMESPACE <> 'PG_TOAST'::REGNAMESPACE::OID
	AND P.PRONAMESPACE <> 'INFORMATION_SCHEMA'::REGNAMESPACE::OID
ORDER BY
	OWNER, OBJECT_ID
;

/* GRANT SELECT PRIVILEGE TO PUBLIC */
GRANT SELECT ON SYS.DBA_ARGUMENTS TO PUBLIC;

/* ALL_ARGUMENTS */
CREATE OR REPLACE VIEW SYS.ALL_ARGUMENTS AS
SELECT
	SYS.ORA_CASE_TRANS(
		PG_GET_USERBYID(P.PROOWNER)::VARCHAR2
	)::VARCHAR2(128) AS OWNER,
	SYS.ORA_CASE_TRANS(P.PRONAME::VARCHAR2)::VARCHAR2(128) AS OBJECT_NAME,
	NULL::VARCHAR2(128) AS PACKAGE_NAME,
	P.OID::VARCHAR2(10)::NUMBER AS OBJECT_ID,
	NULL::VARCHAR2(40) AS OVERLOAD,
	1::NUMBER AS SUBPROGRAM_ID,
	SYS.ORA_CASE_TRANS(
		SQ.ARGUMENT_NAME::VARCHAR2
	)::VARCHAR2(128) AS ARGUMENT_NAME,
	SQ.POSITION::NUMBER AS POSITION,
	CASE
		WHEN P.PROKIND = 'f'
			THEN SQ.POSITION + 1
		ELSE SQ.POSITION
	END::NUMBER AS SEQUENCE,
	0::NUMBER AS DATA_LEVEL,
	CASE
		WHEN T.TYPNAME = ANY(ARRAY['int2', 'int4', 'int8',
								   'numeric', 'number'])
			THEN 'NUMBER'
		WHEN T.TYPNAME = ANY(ARRAY['float4', 'float8'])
			THEN 'FLOAT'
		WHEN T.TYPNAME = 'bpchar'
			THEN 'CHAR'
		ELSE ORA_CASE_TRANS(T.OID::REGTYPE::VARCHAR2)::VARCHAR2(58)
	END::VARCHAR2(30) AS DATA_TYPE,
	CASE
		WHEN P.PRONARGDEFAULTS > 0
			AND SQ.POSITION > (_ORA_ARGS_COUNT(P.OID) - P.PRONARGDEFAULTS)
			THEN 'Y'
		ELSE 'N'
	END::VARCHAR2(1) AS DEFAULTED,
	NULL::LONG AS DEFAULT_VALUE,
	NULL::NUMBER AS DEFAULT_LENGTH,
	CASE
		WHEN SQ.IN_OUT = 'i' OR SQ.IN_OUT IS NULL
			THEN 'IN'
		WHEN SQ.IN_OUT = 'o'
			THEN 'OUT'
		WHEN SQ.IN_OUT = 'b'
			THEN 'IN/OUT'
		ELSE NULL
	END::VARCHAR2(9) AS IN_OUT,
	CASE
		WHEN T.TYPNAME = ANY(ARRAY['int2', 'int4', 'int8',
								   'float4', 'float8',
								   'numeric', 'number'])
			THEN 22
		WHEN T.TYPNAME = ANY(ARRAY['long', 'long_raw'])
			THEN 32760
		ELSE NULL
	END::NUMBER AS DATA_LENGTH,
	CASE
		WHEN T.TYPNAME = ANY(ARRAY['int2', 'int4', 'int8'])
			THEN 38
		WHEN T.TYPNAME = 'float4'
			THEN 63
		WHEN T.TYPNAME = 'float8'
			THEN 126
		WHEN T.TYPNAME = ANY(ARRAY['timestamp', 'timestamptz',
								   'oratimestamp', 'oratimestamptz',
								   'oratimestampltz'])
			THEN 6
		ELSE NULL
	END::NUMBER AS DATA_PRECISION,
	CASE
		WHEN T.TYPNAME = ANY(ARRAY['float4', 'float8'])
			THEN -127
		ELSE NULL
	END::NUMBER AS DATA_SCALE,
	CASE
		WHEN T.TYPNAME = ANY(ARRAY['numeric', 'number',
								   'int2', 'int4', 'int8',
								   'float4', 'float8'])
			THEN 10
		ELSE NULL
	END::NUMBER AS RADIX,
	CASE
		WHEN T.OID::REGTYPE::VARCHAR2(58) = ANY(ARRAY['char',
													  'character',
													  'varchar2',
													  'clob'])
			THEN 'CHAR_CS'
		WHEN T.OID::REGTYPE::VARCHAR2(58) = ANY(ARRAY['nchar', 'nvarchar2',
													  'nclob'])
			THEN 'NCHAR_CS'
	END::VARCHAR2(44) AS CHARACTER_SET_NAME,
	NULL::VARCHAR2(128) AS TYPE_OWNER,
	NULL::VARCHAR2(128) AS TYPE_NAME,
	NULL::VARCHAR2(128) AS TYPE_SUBNAME,
	NULL::VARCHAR2(128) AS TYPE_LINK,
	NULL::VARCHAR2(128) AS TYPE_OBJECT_TYPE,
	CASE
		WHEN T.TYPTYPE = 'b'
			THEN SYS.ORA_CASE_TRANS(T.OID::REGTYPE::VARCHAR2)
		WHEN T.TYPTYPE = 'd' AND T.TYPNAME = 'raw'
			THEN 'RAW'
		WHEN T.TYPTYPE = 'd' AND T.TYPNAME = 'blob'
			THEN 'BLOB'
		WHEN T.TYPTYPE = 'd' AND T.TYPNAME = 'clob'
			THEN 'CLOB'
		WHEN T.TYPTYPE = 'd' AND T.TYPNAME = 'nclob'
			THEN 'CLOB'
		WHEN T.TYPTYPE = 'd' AND T.TYPNAME = 'long'
			THEN 'LONG'
		WHEN T.TYPTYPE = 'd' AND T.TYPNAME = 'long_raw'
			THEN 'LONG_RAW'
		ELSE NULL
	END::VARCHAR2(30) AS PLS_TYPE,
	CASE
		WHEN T.OID::REGTYPE::VARCHAR2(58) = ANY(ARRAY['char',
													  'character',
													  'varchar2'])
			THEN NULL
		ELSE 0
	END::NUMBER AS CHAR_LENGTH,
	CASE
		WHEN T.OID::REGTYPE::VARCHAR2(58) = ANY(ARRAY['char',
													  'character',
													  'varchar2'])
			THEN 'B'
		ELSE '0'
	END::VARCHAR2(1) AS CHAR_USED,
	0::VARCHAR2(256) AS ORIGIN_CON_ID
FROM
	PG_PROC AS P
	LEFT JOIN
	(
		SELECT
			OID,
			NULL AS ARGUMENT_NAME,
			PRORETTYPE AS DATA_TYPE,
			'o' AS IN_OUT,
			0 AS POSITION
		FROM
			PG_PROC
		WHERE
			PROKIND = 'f'
		UNION ALL
		SELECT
			OID,
			UNNEST(PROARGNAMES) AS ARGUMENT_NAME,
			UNNEST(
			CASE
				WHEN PROALLARGTYPES IS NOT NULL
					THEN PROALLARGTYPES
				ELSE PROARGTYPES
			END) AS DATA_TYPE,
			UNNEST(PROARGMODES) AS IN_OUT,
			GENERATE_SERIES(1, SYS._ORA_ARGS_COUNT(OID)) AS POSITION
		FROM
			PG_PROC
	) AS SQ
		ON P.OID = SQ.OID
	LEFT JOIN PG_TYPE AS T
		ON SQ.DATA_TYPE = T.OID
	LEFT JOIN PG_TRIGGER AS TR
		ON P.OID = TR.TGFOID
WHERE
	TR.OID IS NULL 
	AND P.PRONAMESPACE <> 'PG_CATALOG'::REGNAMESPACE::OID
	AND P.PRONAMESPACE <> 'PG_TOAST'::REGNAMESPACE::OID
	AND P.PRONAMESPACE <> 'INFORMATION_SCHEMA'::REGNAMESPACE::OID
	AND HAS_SCHEMA_PRIVILEGE(P.PRONAMESPACE, 'USAGE')
	AND HAS_FUNCTION_PRIVILEGE(P.OID, 'EXECUTE')
ORDER BY
	OWNER, OBJECT_ID
;

/* GRANT SELECT PRIVILEGE TO PUBLIC */
GRANT SELECT ON SYS.ALL_ARGUMENTS TO PUBLIC;

/* USER_ARGUMENTS */
CREATE OR REPLACE VIEW SYS.USER_ARGUMENTS AS
SELECT
	SYS.ORA_CASE_TRANS(P.PRONAME::VARCHAR2)::VARCHAR2(128) AS OBJECT_NAME,
	NULL::VARCHAR2(128) AS PACKAGE_NAME,
	P.OID::VARCHAR2(10)::NUMBER AS OBJECT_ID,
	NULL::VARCHAR2(40) AS OVERLOAD,
	1::NUMBER AS SUBPROGRAM_ID,
	SYS.ORA_CASE_TRANS(
		SQ.ARGUMENT_NAME::VARCHAR2
	)::VARCHAR2(128) AS ARGUMENT_NAME,
	SQ.POSITION::NUMBER AS POSITION,
	CASE
		WHEN P.PROKIND = 'f'
			THEN SQ.POSITION + 1
		ELSE SQ.POSITION
	END::NUMBER AS SEQUENCE,
	0::NUMBER AS DATA_LEVEL,
	CASE
		WHEN T.TYPNAME = ANY(ARRAY['int2', 'int4', 'int8',
								   'numeric', 'number'])
			THEN 'NUMBER'
		WHEN T.TYPNAME = ANY(ARRAY['float4', 'float8'])
			THEN 'FLOAT'
		WHEN T.TYPNAME = 'bpchar'
			THEN 'CHAR'
		ELSE ORA_CASE_TRANS(T.OID::REGTYPE::VARCHAR2)::VARCHAR2(58)
	END::VARCHAR2(30) AS DATA_TYPE,
	CASE
		WHEN P.PRONARGDEFAULTS > 0
			AND SQ.POSITION > (_ORA_ARGS_COUNT(P.OID) - P.PRONARGDEFAULTS)
			THEN 'Y'
		ELSE 'N'
	END::VARCHAR2(1) AS DEFAULTED,
	NULL::LONG AS DEFAULT_VALUE,
	NULL::NUMBER AS DEFAULT_LENGTH,
	CASE
		WHEN SQ.IN_OUT = 'i' OR SQ.IN_OUT IS NULL
			THEN 'IN'
		WHEN SQ.IN_OUT = 'o'
			THEN 'OUT'
		WHEN SQ.IN_OUT = 'b'
			THEN 'IN/OUT'
		ELSE NULL
	END::VARCHAR2(9) AS IN_OUT,
	CASE
		WHEN T.TYPNAME = ANY(ARRAY['int2', 'int4', 'int8',
								   'float4', 'float8',
								   'numeric', 'number'])
			THEN 22
		WHEN T.TYPNAME = ANY(ARRAY['long', 'long_raw'])
			THEN 32760
		ELSE NULL
	END::NUMBER AS DATA_LENGTH,
	CASE
		WHEN T.TYPNAME = ANY(ARRAY['int2', 'int4', 'int8'])
			THEN 38
		WHEN T.TYPNAME = 'float4'
			THEN 63
		WHEN T.TYPNAME = 'float8'
			THEN 126
		WHEN T.TYPNAME = ANY(ARRAY['timestamp', 'timestamptz',
								   'oratimestamp', 'oratimestamptz',
								   'oratimestampltz'])
			THEN 6
		ELSE NULL
	END::NUMBER AS DATA_PRECISION,
	CASE
		WHEN T.TYPNAME = ANY(ARRAY['float4', 'float8'])
			THEN -127
		ELSE NULL
	END::NUMBER AS DATA_SCALE,
	CASE
		WHEN T.TYPNAME = ANY(ARRAY['numeric', 'number',
								   'int2', 'int4', 'int8',
								   'float4', 'float8'])
			THEN 10
		ELSE NULL
	END::NUMBER AS RADIX,
	CASE
		WHEN T.OID::REGTYPE::VARCHAR2(58) = ANY(ARRAY['char',
													  'character',
													  'varchar2',
													  'clob'])
			THEN 'CHAR_CS'
		WHEN T.OID::REGTYPE::VARCHAR2(58) = ANY(ARRAY['nchar', 'nvarchar2',
													  'nclob'])
			THEN 'NCHAR_CS'
	END::VARCHAR2(44) AS CHARACTER_SET_NAME,
	NULL::VARCHAR2(128) AS TYPE_OWNER,
	NULL::VARCHAR2(128) AS TYPE_NAME,
	NULL::VARCHAR2(128) AS TYPE_SUBNAME,
	NULL::VARCHAR2(128) AS TYPE_LINK,
	NULL::VARCHAR2(128) AS TYPE_OBJECT_TYPE,
	CASE
		WHEN T.TYPTYPE = 'b'
			THEN SYS.ORA_CASE_TRANS(T.OID::REGTYPE::VARCHAR2)
		WHEN T.TYPTYPE = 'd' AND T.TYPNAME = 'raw'
			THEN 'RAW'
		WHEN T.TYPTYPE = 'd' AND T.TYPNAME = 'blob'
			THEN 'BLOB'
		WHEN T.TYPTYPE = 'd' AND T.TYPNAME = 'clob'
			THEN 'CLOB'
		WHEN T.TYPTYPE = 'd' AND T.TYPNAME = 'nclob'
			THEN 'CLOB'
		WHEN T.TYPTYPE = 'd' AND T.TYPNAME = 'long'
			THEN 'LONG'
		WHEN T.TYPTYPE = 'd' AND T.TYPNAME = 'long_raw'
			THEN 'LONG_RAW'
		ELSE NULL
	END::VARCHAR2(30) AS PLS_TYPE,
	CASE
		WHEN T.OID::REGTYPE::VARCHAR2(58) = ANY(ARRAY['char',
													  'character',
													  'varchar2'])
			THEN NULL
		ELSE 0
	END::NUMBER AS CHAR_LENGTH,
	CASE
		WHEN T.OID::REGTYPE::VARCHAR2(58) = ANY(ARRAY['char',
													  'character',
													  'varchar2'])
			THEN 'B'
		ELSE '0'
	END::VARCHAR2(1) AS CHAR_USED,
	0::VARCHAR2(256) AS ORIGIN_CON_ID
FROM
	PG_PROC AS P
	LEFT JOIN
	(
		SELECT
			OID,
			NULL AS ARGUMENT_NAME,
			PRORETTYPE AS DATA_TYPE,
			'o' AS IN_OUT,
			0 AS POSITION
		FROM
			PG_PROC
		WHERE
			PROKIND = 'f'
		UNION ALL
		SELECT
			OID,
			UNNEST(PROARGNAMES) AS ARGUMENT_NAME,
			UNNEST(
			CASE
				WHEN PROALLARGTYPES IS NOT NULL
					THEN PROALLARGTYPES
				ELSE PROARGTYPES
			END) AS DATA_TYPE,
			UNNEST(PROARGMODES) AS IN_OUT,
			GENERATE_SERIES(1, SYS._ORA_ARGS_COUNT(OID)) AS POSITION
		FROM
			PG_PROC
	) AS SQ
		ON P.OID = SQ.OID
	LEFT JOIN PG_TYPE AS T
		ON SQ.DATA_TYPE = T.OID
	LEFT JOIN PG_TRIGGER AS TR
		ON P.OID = TR.TGFOID
WHERE
	TR.OID IS NULL 
	AND P.PRONAMESPACE <> 'PG_CATALOG'::REGNAMESPACE::OID
	AND P.PRONAMESPACE <> 'PG_TOAST'::REGNAMESPACE::OID
	AND P.PRONAMESPACE <> 'INFORMATION_SCHEMA'::REGNAMESPACE::OID
	AND P.PROOWNER::REGROLE = CURRENT_USER::REGROLE
ORDER BY
	OBJECT_ID
;

/* GRANT SELECT PRIVILEGE TO PUBLIC */
GRANT SELECT ON SYS.USER_ARGUMENTS TO PUBLIC;
