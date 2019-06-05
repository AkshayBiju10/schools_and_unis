CREATE TABLE IF NOT EXISTS ADMISSION_RATE_TABLE (
	ID			int			NOT NULL UNIQUE PRIMARY KEY,
	rate		float		NOT NULL UNIQUE				/* for a single campus */
);

CREATE TABLE IF NOT EXISTS ADMISSION_RATE_ALL_TABLE (
	ID			int			NOT NULL UNIQUE PRIMARY KEY,
	rate_all	float		NOT NULL UNIQUE				/* averaged over multiple campuses (for such institutions) */
);

CREATE TABLE IF NOT EXISTS SCHOOL_ADMISSION_RATE (
	school_id	int			NOT NULL UNIQUE,
	rate_id		int			NOT NULL UNIQUE,				/* for single campus institutions or for individual branches of multi-branch institutions */
    PRIMARY KEY (school_id, rate_id),
    FOREIGN KEY (school_id) REFERENCES SCHOOL_TABLE (ID),
    FOREIGN KEY (rate_id) REFERENCES ADMISSION_RATE_TABLE (ID)
);

CREATE TABLE IF NOT EXISTS SCHOOL_ADMISSION_RATE_ALL (
	school_id	int			NOT NULL UNIQUE,
	rate_all_id		int			NOT NULL UNIQUE,				/* for multiple campus institutions */
    PRIMARY KEY (school_id, rate_all_id),
    FOREIGN KEY (school_id) REFERENCES SCHOOL_TABLE (ID),
    FOREIGN KEY (rate_id) REFERENCES ADMISSION_RATE_ALL_TABLE (ID)
);

/*

CREATE TABLE IF NOT EXISTS SAT_SCORES_25_P_TABLE (			# 25th percentile  
	ID			int			NOT NULL UNIQUE PRIMARY KEY,
	crit_read	float		NOT NULL UNIQUE,
    math		float		NOT NULL UNIQUE,
	writing		float		NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS SAT_SCORES_75_P_TABLE (			# 75th percentile 
	ID			int			NOT NULL UNIQUE PRIMARY KEY,
	crit_read	float		NOT NULL UNIQUE,
    math		float		NOT NULL UNIQUE,
	writing		float		NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS SAT_SCORES_MID_P_TABLE (			# Midpoint of scores 
	ID			int			NOT NULL UNIQUE PRIMARY KEY,
	crit_read	float		NOT NULL UNIQUE,
    math		float		NOT NULL UNIQUE,
	writing		float		NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS ACT_SCORES_25_P_TABLE (			# 25th percentile 
	ID			int			NOT NULL UNIQUE PRIMARY KEY,
	cumulative	float		NOT NULL UNIQUE,
    math		float		NOT NULL UNIQUE,
	writing		float		NOT NULL UNIQUE,
    english		float		NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS ACT_SCORES_75_P_TABLE (			# 75th percentile 
	ID			int			NOT NULL UNIQUE PRIMARY KEY,
	cumulative	float		NOT NULL UNIQUE,
    math		float		NOT NULL UNIQUE,
	writing		float		NOT NULL UNIQUE,
    english		float		NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS ACT_SCORES_MID_P_TABLE (			# Midpoint of scores 
	ID			int			NOT NULL UNIQUE PRIMARY KEY,
	cumulative	float		NOT NULL UNIQUE,
    math		float		NOT NULL UNIQUE,
	writing		float		NOT NULL UNIQUE,
    english		float		NOT NULL UNIQUE
);
*/

CREATE TABLE IF NOT EXISTS SAT_SCORES_TABLE (			  
	ID			int			NOT NULL UNIQUE PRIMARY KEY,
/*  _25_p		int			NOT NULL,					# flag for 25th percentile
    _75_p		int			NOT NULL,					# flag for 75th percentile
    _mid		int			NOT NULL,					# flag for mid point scores
*/
	crit_read	float		NOT NULL UNIQUE,
    math		float		NOT NULL UNIQUE,
	writing		float		NOT NULL UNIQUE,
	score_type	ENUM ('25_P','75_P','MID_P')		# Corr. to 25th percentile, 75th percentile, and midpoint scores
);
/*
CREATE VIEW SAT_SCORES_TABLE AS SELECT * FROM SAT_SCORES WHERE (_25_p XOR _75_p XOR _mid  =  1) AND (_25_p * _75_p * _mid = 0) WITH CHECK OPTION;
*/

CREATE TABLE IF NOT EXISTS ACT_SCORES_TABLE (			
	ID			int			NOT NULL UNIQUE PRIMARY KEY,
   /*
   _25_p		int			NOT NULL,					# flag for 25th percentile
    _75_p		int			NOT NULL,					# flag for 75th percentile
    _mid		int			NOT NULL,					# flag for mid point scores
    */
	cumulative	float		NOT NULL UNIQUE,
    math		float		NOT NULL UNIQUE,
	writing		float		NOT NULL UNIQUE,
    english		float		NOT NULL UNIQUE,
	score_type	ENUM ('25_P','75_P','MID_P')		# Corr. to 25th percentile, 75th percentile, and midpoint scores
);
/*
CREATE VIEW ACT_SCORES_TABLE AS SELECT * FROM ACT_SCORES WHERE (_25_p XOR _75_p XOR _mid  =  1) AND (_25_p * _75_p * _mid = 0) WITH CHECK OPTION;
*/

CREATE TABLE IF NOT EXISTS SCHOOL_SAT_SCORES (
	school_id		int		NOT NULL UNIQUE,
    sat_scores_id	int		NOT NULL,
    PRIMARY KEY (school_id, sat_scores_id),
    FOREIGN KEY (school_id)	REFERENCES SCHOOL_TABLE (ID),
    FOREIGN KEY (sat_scores_id)	REFERENCES SAT_SCORES_TABLE (ID)
);

CREATE TABLE IF NOT EXISTS SCHOOL_ACT_SCORES (
	school_id		int		NOT NULL UNIQUE,
    act_scores_id	int		NOT NULL,
    PRIMARY KEY (school_id, act_scores_id),
    FOREIGN KEY (school_id)	REFERENCES SCHOOL_TABLE (ID),
    FOREIGN KEY (act_scores_id)	REFERENCES ACT_SCORES_TABLE (ID)
);

CREATE TABLE IF NOT EXISTS SAT_AVG_TABLE (
	ID			int			NOT NULL UNIQUE PRIMARY KEY,
	sat_avg		float		NOT NULL UNIQUE				# for a single campus 
);

CREATE TABLE IF NOT EXISTS SAT_AVG_ALL_TABLE (
	ID			int			NOT NULL UNIQUE PRIMARY KEY,
	sat_avg_all	float		NOT NULL UNIQUE				# averaged over multiple campuses (for such institutions) 
);

CREATE TABLE IF NOT EXISTS SCHOOL_SAT_AVG (
	school_id		int		NOT NULL UNIQUE,
    sat_avg_id		int		NOT NULL,
    PRIMARY KEY (school_id, sat_avg_id),
    FOREIGN KEY (school_id)	REFERENCES SCHOOL_TABLE (ID),
    FOREIGN KEY (sat_avg_id)	REFERENCES SAT_AVG_TABLE (ID)
);

CREATE TABLE IF NOT EXISTS SCHOOL_SAT_AVG_ALL (
	school_id		int		NOT NULL UNIQUE,
    sat_avg_all_id		int		NOT NULL,
    PRIMARY KEY (school_id, sat_avg_all_id),
    FOREIGN KEY (school_id)	REFERENCES SCHOOL_TABLE (ID),
    FOREIGN KEY (sat_avg_all_id) REFERENCES SAT_AVG_ALL_TABLE (ID)
);





