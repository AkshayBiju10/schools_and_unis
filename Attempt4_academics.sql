CREATE TABLE IF NOT EXISTS SUBJECT_TABLE (
	ID				int			NOT NULL UNIQUE PRIMARY KEY,
    subj_name		varchar(64)	NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS SCHOOL_ACADEMICS_TABLE (
	ID				int			NOT NULL UNIQUE PRIMARY KEY,
    subj_id			int			NOT NULL,
    school_id		int			NOT NULL,
    deg_percent		int			NOT NULL,
    UNIQUE (subj_id, school_id),
    FOREIGN KEY (subj_id) REFERENCES SUBJECT_TABLE (ID),
    FOREIGN KEY (school_id) REFERENCES SCHOOL_TABLE (ID),    
    /* flags for certificates */ 
    lt_1_yr					int			NOT NULL,
    lt_2_yr					int			NOT NULL,
    lt_4_yr					int			NOT NULL,
    /* flags for degrees */
    associate				int			NOT NULL,
    bachelors				int			NOT NULL
);




