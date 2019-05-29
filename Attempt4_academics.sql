CREATE TABLE IF NOT EXISTS SUBJECT_TABLE (
	ID				int			NOT NULL UNIQUE,
    subj_name		varchar(64)	NOT NULL UNIQUE,
    PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS ACADEMICS_TABLE (
	ID				int			NOT NULL UNIQUE PRIMARY KEY,
    subj_id			int			NOT NULL UNIQUE,
    school_id		int			NOT NULL UNIQUE,
    deg_percent		int			NOT NULL,
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




