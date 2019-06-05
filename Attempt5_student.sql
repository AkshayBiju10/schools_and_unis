CREATE TABLE IF NOT EXISTS STUDENT_INFO (
	ID				int		NOT NULL UNIQUE PRIMARY KEY,
	size			int		NOT NULL, 
    all_enroll		int		NOT NULL
);

CREATE TABLE IF NOT EXISTS STUDENT_CATEGORY_TABLE (
	ID			int				NOT NULL UNIQUE PRIMARY KEY,
    category	varchar(64)		NOT NULL,
    _share		float			NOT NULL		
);

CREATE TABLE IF NOT EXISTS SCHOOL_STUDENT_CATEGORY (
	school_id		int		NOT NULL,
    categ_id		int		NOT NULL,
    PRIMARY KEY (school_id,categ_id),
    FOREIGN KEY (school_id) REFERENCES SCHOOL_TABLE (ID),
    FOREIGN KEY (categ_id) REFERENCES STUDENT_CATEGORY_TABLE (ID)
);

# Example of selecting school from a particular category and share using the above tables
	  
# SELECT scl_name FROM SCHOOL_TABLE WHERE ID IN (SELECT school_id FROM SCHOOL_STUDENT_CATEGORY WHERE categ_id = (SELECT ID FROM STUDENT_CATEGORY_TABLE WHERE category = 'unknown' AND _share = 0.09 )) 


CREATE TABLE IF NOT EXISTS STUDENT_PART_TIME (
	ID			int			NOT NULL UNIQUE PRIMARY KEY,
	_share		float		NOT NULL,
    _share_2000 float		NOT NULL
);

CREATE TABLE IF NOT EXISTS GRANT_TABLE (
	ID				int		NOT NULL UNIQUE,
	pell_share		float	NOT NULL UNIQUE 
);

CREATE TABLE IF NOT EXISTS SCHOOL_GRANT (
	school_id	int		NOT NULL UNIQUE,
    grant_id	int		NOT NULL,
    PRIMARY KEY (school_id, grant_id),
    FOREIGN KEY (school_id) REFERENCES SCHOOL_TABLE (ID),
    FOREIGN KEY (grant_id) REFERENCES GRANT_TABLE (ID)
);

CREATE TABLE IF NOT EXISTS AVG_AGE_ENTRY (
	ID				int		NOT NULL UNIQUE PRIMARY KEY,
    _share			float	NOT NULL UNIQUE,
	_share_squared	float	NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS DEMOGRAPHIC_TYPE (
	ID			int		NOT NULL UNIQUE PRIMARY KEY,
    _share		float	NOT NULL UNIQUE,
    demog_type	ENUM ('OVER_23_AT_ENTRY','FEMALE_SHARE','MARRIED','DEPENDENT','INDEPENDENT','VETERAN','FIRST_GENERATION','FIRST_TIME_FULL_TIME','UNDERGRAD_OVER_25')
);

CREATE TABLE IF NOT EXISTS UNDERGRAD_DEG_SEEKING (
	ID			int		NOT NULL UNIQUE PRIMARY KEY,
    men_share	float	NOT NULL,
	women_share	float	NOT NULL,
    UNIQUE (men_share, women_share)
);

CREATE TABLE IF NOT EXISTS UNDERGRAD_OTHERS (
	ID			int		NOT NULL UNIQUE PRIMARY KEY,
    num			int		NOT NULL UNIQUE,
    _type		ENUM  ('non-deg-seeking','grant-or-loan')	NOT NULL 
);

CREATE TABLE IF NOT EXISTS GRAD_STUDENTS (
	ID			int		NOT NULL UNIQUE PRIMARY KEY,
    num			int		NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS AVG_FAMILY_INCOME (
	ID				int		NOT NULL UNIQUE PRIMARY KEY,
    _avg			float	NOT NULL,
    _avg_indep		float	NOT NULL,
    _avg_log		float	NOT NULL,
    _avg_dep_2014   int		NOT NULL,
    _avg_indep_2014	int		NOT NULL
);	

CREATE TABLE IF NOT EXISTS INCOME_TABLE (
	ID							int		NOT NULL UNIQUE PRIMARY KEY,
    avg_family_income_id		int		NOT NULL,
    med_family_income			float	NOT NULL,
    med_hh_income				float	NOT NULL,
    med_hh_income_log			float	NOT NULL
);

CREATE TABLE IF NOT EXISTS SCHOOL_INCOME (
	school_id		int		NOT NULL,
    income_id		int		NOT NULL,
    PRIMARY KEY (school_id, income_id),
    FOREIGN KEY (school_id) REFERENCES SCHOOL_TABLE (ID),
    FOREIGN KEY (income_id) REFERENCES INCOME_TABLE (ID)
);

CREATE TABLE IF NOT EXISTS HOME_ZIP_TABLE (
	ID				int			NOT NULL PRIMARY KEY,
    _category		varchar(64)	NOT NULL,
    _share			float		NOT NULL
);

CREATE TABLE IF NOT EXISTS SCHOOL_HOME_ZIP (
	school_id		int		NOT NULL,
    home_zip_id		int		NOT NULL,
    PRIMARY KEY (school_id, home_zip_id),
    FOREIGN KEY (school_id) REFERENCES SCHOOL_TABLE (ID),
    FOREIGN KEY (home_zip_id) REFERENCES HOME_ZIP_TABLE (ID)
);

CREATE TABLE IF NOT EXISTS POVERTY_RATE_TABLE (
	ID		int		NOT NULL UNIQUE PRIMARY KEY,
    rate	float	NOT NULL
);

CREATE TABLE IF NOT EXISTS SCHOOL_POVERTY_RATE (
	school_id		int		NOT NULL UNIQUE,
    poverty_id		int		NOT NULL,
    PRIMARY KEY (school_id, poverty_id),
    FOREIGN KEY (school_id) REFERENCES SCHOOL_TABLE (ID),
    FOREIGN KEY (poverty_id) REFERENCES POVERTY_RATE_TABLE (ID)
);

CREATE TABLE IF NOT EXISTS UNEMPLOYMENT_RATE_TABLE (
	ID		int		NOT NULL UNIQUE PRIMARY KEY,
    rate	float	NOT NULL
);

CREATE TABLE IF NOT EXISTS SCHOOL_UNEMPLOYMENT_RATE (
	school_id		int		NOT NULL UNIQUE,
    unemp_id		int		NOT NULL,
    PRIMARY KEY (school_id, unemp_id),
    FOREIGN KEY (school_id) REFERENCES SCHOOL_TABLE (ID),
    FOREIGN KEY (unemp_id) REFERENCES UNEMPLOYMENT_RATE_TABLE (ID)
);

CREATE TABLE IF NOT EXISTS FAFSA_COHORT_TABLE (
	ID			int		NOT NULL UNIQUE PRIMARY KEY,
    num			int		NOT NULL UNIQUE 				# No. of students who are able to apply for FAFSA
);

CREATE TABLE IF NOT EXISTS SCHOOL_FAFSA_COHORT (
	school_id			int		NOT NULL UNIQUE,
    fafsa_cohort_id		int		NOT NULL,
    PRIMARY KEY (school_id, fafsa_cohort_id),
    FOREIGN KEY (school_id) REFERENCES SCHOOL_TABLE (ID),
    FOREIGN KEY (fafsa_cohort_id) REFERENCES FAFSA_COHORT_TABLE (ID)
);

CREATE TABLE IF NOT EXISTS FAFSA_SENT_TABLE (
	ID				int 	NOT NULL UNIQUE PRIMARY KEY,
    overall			int		NOT NULL,		# Avg no. of students who submitted applications
    only_1_td		float	NOT NULL,		# share (data produced by Treasury Department)
    only_2_td		float	NOT NULL,		# share (data produced by Treasury Department)
    only_3_td		float	NOT NULL,		# share (data produced by Treasury Department)
    only_4_td		float	NOT NULL,		# share (data produced by Treasury Department)
    atleast_5_td	float	NOT NULL,		# share (data produced by Treasury Department)
	atleast_2		float	NOT NULL,		# share
	atleast_3		float	NOT NULL,		# share
	atleast_4		float	NOT NULL,		# share
	atleast_5		float	NOT NULL		# share
);

CREATE TABLE IF NOT EXISTS SCHOOL_FAFSA_SENT (
	school_id		int		NOT NULL UNIQUE,
    fafsa_id		int		NOT NULL,
    PRIMARY KEY (school_id, fafsa_id),
    FOREIGN KEY (school_id) REFERENCES SCHOOL_TABLE (ID),
    FOREIGN KEY (fafsa_id) REFERENCES FAFSA_SENT_TABLE (ID)
);

CREATE TABLE IF NOT EXISTS COHORT_TABLE (
	ID			int		NOT NULL UNIQUE PRIMARY KEY,
    cohort_type	ENUM ('FAMILY_INCOME_OVERALL','FAMILY_INCOME_INDEP','FAMILY_INCOME_DEP','VALID_DEPENDENCY','PARENTS_EDU_LEVEL','FAFSA')
);

CREATE TABLE IF NOT EXISTS STUDENT_DEMOGRAPHIX_TABLE (
	ID					int		NOT NULL UNIQUE PRIMARY KEY,			
    student_id			int		NOT NULL UNIQUE,
    demog_type_id		int	 	NOT NULL UNIQUE,
    undergrad_deg_id	int	 	NOT NULL UNIQUE,
    income_id			int		NOT NULL UNIQUE,
    home_zip_id			int		NOT NULL UNIQUE,
    poverty_rate_id		int		NOT NULL UNIQUE,
    unemp_rate_id		int		NOT NULL UNIQUE,
    fafsa_sent_id		int		NOT NULL UNIQUE,
    FOREIGN KEY (student_id) REFERENCES STUDENT_TYPE (ID),    
    FOREIGN KEY (demog_type_id) REFERENCES DEMOGRAPHIC_TYPE (ID),
    FOREIGN KEY (undergrad_deg_id) REFERENCES UNDERGRAD_DEG_SEEKING (ID),
    FOREIGN KEY (income_id) REFERENCES INCOME_TABLE (ID),
    FOREIGN KEY (home_zip_id) REFERENCES HOME_ZIP_TABLE (ID),
    FOREIGN KEY (poverty_rate_id) REFERENCES POVERTY_RATE_TABLE (ID),
	FOREIGN KEY (unemp_rate_id) REFERENCES UNEMPLOYMENT_RATE_TABLE (ID),
    FOREIGN KEY (fafsa_sent_id) REFERENCES FAFSA_SENT_TABLE (ID)	
);    

CREATE TABLE IF NOT EXISTS SCHOOL_STUDENT_COHORT (
	school_id		int		NOT NULL UNIQUE,
    stud_cohort_id	int		NOT NULL,
    PRIMARY KEY (school_id, demog_id),
    FOREIGN KEY (school_id) REFERENCES SCHOOL_TABLE (ID),
    FOREIGN KEY (demog_id) REFERENCES STUDENT_DEMOGRAPHIX_TABLE (ID)    
);

CREATE TABLE IF NOT EXISTS SCHOOL_STUDENT_DEMOGRAPHIX (
	school_id		int		NOT NULL UNIQUE,
    stud_demog_id	int		NOT NULL,
    PRIMARY KEY (school_id, demog_id),
    FOREIGN KEY (school_id) REFERENCES SCHOOL_TABLE (ID),
    FOREIGN KEY (demog_id) REFERENCES STUDENT_DEMOGRAPHIX_TABLE (ID)    
);

CREATE TABLE IF NOT EXISTS RELEG_TABLE (
	ID				int		NOT NULL UNIQUE PRIMARY KEY,
    four_year		float	NOT NULL,
    lt_four_year	float	NOT NULL,
    pooled_yrs_used int		NOT NULL,
    UNIQUE (four_year, lt_four_year, pooled_yrs_used),
    time_type		ENUM	('full-time','part-time')	NOT NULL
);

CREATE TABLE IF NOT EXISTS RELEG_POOLED_TABLE (
	ID				int		NOT NULL UNIQUE PRIMARY KEY,
    four_year		float	NOT NULL,
    lt_four_year	float	NOT NULL,
    UNIQUE (four_year, lt_four_year),
    time_type		ENUM	('full-time-pooled','part-time-pooled')	NOT NULL,
    category		ENUM	('suppressed','cohort')		NOT NULL
);

CREATE TABLE IF NOT EXISTS RETENTION_RATE_TABLE (
	ID					int		NOT NULL UNIQUE PRIMARY KEY,
    overall_ft			int		NOT NULL UNIQUE,
	releg_id			int		NOT NULL UNIQUE,
    releg_pooled_id		int		NOT NULL UNIQUE,
    UNIQUE (releg_id, releg_pooled_id),
    FOREIGN KEY (releg_id) REFERENCES RELEG_TABLE (ID),
    FOREIGN KEY (releg_pooled_id) REFERENCES RELEG_POOLED_TABLE (ID)
);

CREATE TABLE IF NOT EXISTS SCHOOL_RETENTION_RATE (
	school_id		int		NOT NULL UNIQUE,
    retention_id	int		NOT NULL,
    PRIMARY KEY (school_id, retention_id),
    FOREIGN KEY (school_id) REFERENCES SCHOOL_TABLE (ID),
    FOREIGN KEY (retention_id) REFERENCES RETENTION_RATE_TABLE (ID)    
);

CREATE TABLE IF NOT EXISTS INCOME_SHARE_TABLE (
	ID			int			NOT NULL UNIQUE PRIMARY KEY,
    aided		float		NOT NULL,
    indep		float		NOT NULL,
    dep			float		NOT NULL,
    range_type	ENUM ('LOW','MID-1','MID-2','HIGH-1','HIGH-2')	NOT NULL
);

CREATE TABLE IF NOT EXISTS SCHOOL_INCOME_SHARE (
	school_id	int		NOT NULL UNIQUE,
    income_id	int		NOT NULL,
    PRIMARY KEY (school_id, income_id),
    FOREIGN KEY (school_id) REFERENCES SCHOOL_TABLE (ID),
    FOREIGN KEY (income_id) REFERENCES INCOME_SHARE_TABLE (ID)
);

CREATE TABLE IF NOT EXISTS PARENTS_EDU_TABLE (
	ID				int		NOT NULL UNIQUE PRIMARY KEY,
    middle_school	float	NOT NULL,
    high_school		float	NOT NULL,
    some_college	float	NOT NULL,
    UNIQUE (middle_school, high_school, some_college)
);

CREATE TABLE IF NOT EXISTS SCHOOL_PARENTS_EDU (
	school_id		int		NOT NULL UNIQUE,
    parents_edu_id	int		NOT NULL,
    PRIMARY KEY (school_id, parents_edu_id),
    FOREIGN KEY      (school_id) REFERENCES      SCHOOL_TABLE (ID),
    FOREIGN KEY (parents_edu_id) REFERENCES PARENTS_EDU_TABLE (ID)
);

