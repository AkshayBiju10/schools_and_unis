CREATE DATABASE IF NOT EXISTS chotta_db;

CREATE TABLE IF NOT EXISTS SCHOOL_TABLE (
	ID				int			NOT NULL UNIQUE,
    scl_name		varchar(64)	NOT NULL UNIQUE,
    curr_operating	boolean		NOT NULL,
    open_admissions	boolean		NOT NULL,			# OPEN ADMISSIONS POLICY
    PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS ID_TABLE (
	ID			int			NOT NULL UNIQUE PRIMARY KEY,
    unitid		int			NOT NULL UNIQUE,
    ope8id		int			NOT NULL UNIQUE,
    ope6id		int			NOT NULL				# Same for schools under same university, or for branches of the same university 
);

CREATE TABLE IF NOT EXISTS SCHOOL_ID (			
	school_id		int		NOT NULL UNIQUE,
	id_id			int		NOT NULL UNIQUE,
    PRIMARY KEY (school_id, id_id),
    FOREIGN KEY (school_id) REFERENCES SCHOOL_TABLE (ID),
    FOREIGN KEY (id_id) REFERENCES ID_TABLE (ID)
);

CREATE TABLE IF NOT EXISTS CITY_TABLE (
	ID			int			NOT NULL UNIQUE PRIMARY KEY,
	city_name	varchar(64)	NOT NULL UNIQUE					
);

CREATE TABLE IF NOT EXISTS STATE_TABLE (
	ID			int			NOT NULL UNIQUE PRIMARY KEY,
	state_name	varchar(64)	NOT NULL UNIQUE,
    fips_code	varchar(2)	NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS REGION_TABLE (
	ID			int			NOT NULL UNIQUE PRIMARY KEY,
	region		int			NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS STATE_REGION (
	ID			int		NOT NULL UNIQUE PRIMARY KEY,
	state_id	int		NOT NULL UNIQUE,
    region_id	int		NOT NULL,							# Because one region has many states 
    FOREIGN KEY (state_id) REFERENCES STATE_TABLE (ID),			
    FOREIGN KEY (region_id) REFERENCES REGION_TABLE (ID)    
);

CREATE TABLE IF NOT EXISTS ZIPCODE_TABLE (
	ID			int			NOT NULL UNIQUE PRIMARY KEY,
	zipcode		int			NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS LOCALE_TABLE (					
	ID			int			NOT NULL UNIQUE PRIMARY KEY,
	locale		int			NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS DEG_URB_TABLE (
	ID			int			NOT NULL UNIQUE PRIMARY KEY,
	degree		int			NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS COORDINATES_TABLE (
	ID			int			NOT NULL UNIQUE PRIMARY KEY,
	latitude	float		NOT NULL,
	longitude	float		NOT NULL,
    UNIQUE (latitude, longitude)
);

CREATE TABLE IF NOT EXISTS LOCATION_TABLE (						# Table that has all info concerning location of the school 
	ID				int			NOT NULL UNIQUE PRIMARY KEY,
    scl_city_id		int			NOT NULL,
    scl_state_id	int			NOT NULL,
    zip_code_id		int			NOT NULL UNIQUE,
	locale_id		int			NOT NULL,
	deg_urb_id		int			NOT NULL,
    coord_id		int			NOT NULL UNIQUE,
    UNIQUE (scl_city_id, scl_state_id, zip_code_id, locale_id, deg_urb_id, coord_id),
	FOREIGN KEY (scl_city_id) REFERENCES CITY_TABLE (ID),
	FOREIGN KEY (scl_state_id) REFERENCES STATE_REGION (ID),
	FOREIGN KEY (zip_code_id) REFERENCES ZIPCODE_TABLE (ID),
	FOREIGN KEY (locale_id) REFERENCES LOCALE_TABLE (ID),
    FOREIGN KEY (deg_urb_id) REFERENCES DEG_URB_TABLE (ID),
    FOREIGN KEY (coord_id) REFERENCES COORDINATES_TABLE (ID)
);

CREATE TABLE IF NOT EXISTS SCHOOL_LOCATION (
	school_id	int		NOT NULL UNIQUE,
    location_id	int		NOT NULL UNIQUE,
    PRIMARY KEY (school_id, location_id),
    FOREIGN KEY (school_id) REFERENCES SCHOOL_TABLE (ID),
    FOREIGN KEY (location_id) REFERENCES LOCATION_TABLE (ID)
);

CREATE TABLE IF NOT EXISTS ACCREDITOR_TABLE (
	ID			int			NOT NULL UNIQUE PRIMARY KEY,
    acc_code	varchar(64)	NOT NULL UNIQUE,		 # Four to five letter code 
	agency_name	varchar(64)	NOT NULL UNIQUE			 # Eg : COE for Council on Occupational Education 
);


CREATE TABLE IF NOT EXISTS SCHOOL_ACCREDITOR (
	school_id	int		NOT NULL UNIQUE,
    acc_id		int		NOT NULL,		# An agency can function as the accreditor for many schools  
    PRIMARY KEY (school_id, acc_id),
    FOREIGN KEY (school_id) REFERENCES SCHOOL_TABLE (ID),
    FOREIGN KEY (acc_id) REFERENCES ACCREDITOR_TABLE (ID)
);

CREATE TABLE IF NOT EXISTS URL_TABLE (
	ID				int			NOT NULL UNIQUE PRIMARY KEY,
    scl_url			varchar(64)	NOT NULL UNIQUE,
    price_calc_url	varchar(64)	NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS SCHOOL_URL (
	school_id	int		NOT NULL UNIQUE,
    url_id		int		NOT NULL UNIQUE,
    PRIMARY KEY (school_id, url_id),
    FOREIGN KEY (school_id) REFERENCES SCHOOL_TABLE (ID),
    FOREIGN KEY (url_id) REFERENCES URL_TABLE (ID)
);

/*
CREATE TABLE IF NOT EXISTS DEGREES_AWRDD_TABLE (
	ID			int			NOT NULL UNIQUE PRIMARY KEY,
    deg_deg		int			NOT NULL,
    deg_name	varchar(64)	NOT NULL,
    UNIQUE (deg_name, deg_deg)				
);
*/

CREATE TABLE IF NOT EXISTS DEGREES_AWRDD_TABLE (
	ID			int			NOT NULL UNIQUE PRIMARY KEY,
    deg_deg		int			NOT NULL,											# Range is 0 through 4
    deg_name ENUM ('predominant','predominant_recoded','highest') NOT NULL,
    UNIQUE (deg_name, deg_deg)				
);

# Suppose the degree awarded is 'Predominant' and it has degrees from 0 through 5. Then, we can add the names of the degrees awarded with their available degrees.For example, 

# INSERT INTO DEGREES_AWRDD_TABLE VALUES (1,'predominant',0),(2,'predominant',1),(3,'predominant',2),(4,'predominant',3),(5,'predominant',4),(6,'predominant',5);

# We can do the same for recoded, highest degree etc. 

CREATE TABLE IF NOT EXISTS SCHOOL_DEGREES (
	school_id	int		NOT NULL,
    deg_id		int		NOT NULL,
    PRIMARY KEY (school_id, deg_id),
    FOREIGN KEY (school_id) REFERENCES SCHOOL_TABLE (ID),
    FOREIGN KEY (deg_id) REFERENCES DEGREES_AWRDD_TABLE (ID)
);

/*
CREATE TABLE IF NOT EXISTS UNDER_INV_TABLE (				# Only considering Heightened Cash Monitoring 2 as per the yaml file  
	ID			int			NOT NULL UNIQUE PRIMARY KEY,		
	reason		int			NOT NULL UNIQUE,				# We can put integers for mapping onto the reasons for HCM2 
	reason_desc	int			NOT NULL UNIQUE					# Optional field for storing reason of HCM2  
);
*/

CREATE TABLE IF NOT EXISTS UNDER_INV_TABLE (
	ID		int			NOT NULL UNIQUE PRIMARY KEY,
    flag	boolean		NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS SCHOOL_UNDER_INV (
	school_id		int		NOT NULL UNIQUE,
    under_inv_id	int		NOT NULL,
    PRIMARY KEY (school_id, deg_id),
    FOREIGN KEY (school_id) REFERENCES SCHOOL_TABLE (ID),
    FOREIGN KEY (under_inv_id) REFERENCES UNDER_INV_TABLE (ID)
);


CREATE TABLE IF NOT EXISTS CAMPUS_INFO_TABLE (				
	ID			int			NOT NULL UNIQUE PRIMARY KEY,
	main		boolean		NOT NULL,						 
    branches	int			NOT NULL,						# No. of branches
    UNIQUE (main, branches)
);

CREATE TABLE IF NOT EXISTS SCHOOL_CAMPUS_INFO (
	school_id		int		NOT NULL UNIQUE,
    campus_info_id	int		NOT NULL,
    PRIMARY KEY (school_id, campus_info_id),
    FOREIGN KEY (school_id) REFERENCES SCHOOL_TABLE (ID),
    FOREIGN KEY (campus_info_id) REFERENCES CAMPUS_INFO_TABLE (ID)
);

CREATE TABLE IF NOT EXISTS OWN_TABLE (
	ID			 int			NOT NULL UNIQUE PRIMARY KEY,
	control	ENUM ('Public','Private Non-profit','Private for profit')			
);

CREATE TABLE IF NOT EXISTS SCHOOL_OWN (
	school_id		int		NOT NULL UNIQUE,
    control_id		int		NOT NULL,
    PRIMARY KEY (school_id, control_id),
    FOREIGN KEY (school_id) REFERENCES SCHOOL_TABLE (ID),
    FOREIGN KEY (control_id) REFERENCES OWN_TABLE (ID)
);

CREATE TABLE IF NOT EXISTS CARNEGIE_TABLE (
	ID			int			NOT NULL UNIQUE PRIMARY KEY,
    cc_type		ENUM ('BASIC','UGPROF','SIZESET')	NOT NULL,
	classif		int			NOT NULL UNIQUE,
    descr		varchar(64)	NOT NULL UNIQUE			# Optional field
);

/*
CREATE TABLE IF NOT EXISTS CC_TABLE (
	ID			int			NOT NULL UNIQUE PRIMARY KEY,
	classif		int			NOT NULL UNIQUE,
    descr		varchar(64)	NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS CC_TABLE (
	ID			int			NOT NULL UNIQUE PRIMARY KEY,
	classif		int			NOT NULL UNIQUE,
    descr		varchar(64)	NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS CARNEGIE_TABLE (
	ID			int			NOT NULL UNIQUE PRIMARY KEY,
	basic_id	int			NOT NULL,
    ugprof_id	int			NOT NULL,
    sizeset_id	int			NOT NULL,
    UNIQUE (basic_id, ugprof_id, sizeset_id),
    FOREIGN KEY (basic_id) REFERENCES CCBASIC_TABLE (ID),
    FOREIGN KEY (ugprof_id) REFERENCES CCUGPROF_TABLE (ID),
    FOREIGN KEY (sizeset_id) REFERENCES CCSIZESET_TABLE (ID)    
);
*/
CREATE TABLE IF NOT EXISTS SCHOOL_CARNEGIE(
	school_id		int		NOT NULL UNIQUE,
    carnegie_id		int		NOT NULL,
    PRIMARY KEY (school_id, minor_id),
    FOREIGN KEY (school_id) REFERENCES SCHOOL_TABLE (ID),
    FOREIGN KEY (carnegie_id) REFERENCES CARNEGIE_TABLE (ID)
);

CREATE TABLE IF NOT EXISTS MINORITY_TABLE (
	ID			int			NOT NULL UNIQUE PRIMARY KEY,	# We can enter records like (some_id_number, 'historically black') 
	minor_name	varchar(64)	NOT NULL UNIQUE					# Instead of making flags for each minority 
);

CREATE TABLE IF NOT EXISTS SCHOOL_MINORITY(
	school_id	int		NOT NULL,			
    minor_id	int		NOT NULL,
    PRIMARY KEY (school_id, minor_id),
    FOREIGN KEY (school_id) REFERENCES SCHOOL_TABLE (ID),
    FOREIGN KEY (minor_id) REFERENCES MINORITY_TABLE (ID)
);

/*
CREATE TABLE IF NOT EXISTS BIAS (					
	ID			int			NOT NULL UNIQUE PRIMARY KEY,	
	men_only	int			NOT NULL,				
    women_only	int			NOT NULL,				# (ID, men_only, women_only, dist_nly) = (, 1,0,x), (, 0,1, x), (, 0, 0, x)
    dist_only	int			NOT NULL				# Added new field
);
*/
# CREATE VIEW BIAS_TABLE AS SELECT * FROM BIAS WHERE men_only * women_only = 0 WITH CHECK OPTION;     # View to eliminate (some_id_number,1,1,0) and (some_id_number,1,1,1)  

#Enums

CREATE TABLE IF NOT EXISTS BIAS_TABLE (
	ID			int			NOT NULL UNIQUE PRIMARY KEY,
    bias_type	ENUM ('CO-ED','MEN-ONLY','WOMEN-ONLY')
);

CREATE TABLE IF NOT EXISTS SCHOOL_BIAS (
	school_id	int		NOT NULL UNIQUE,
    bias_id		int		NOT NULL,		# Not unique as more than one schools can be coed / men-only / women-only  
    PRIMARY KEY (school_id, bias_id),
    FOREIGN KEY (school_id) REFERENCES SCHOOL_TABLE (ID),
    FOREIGN KEY (bias_id) REFERENCES BIAS_TABLE (ID)
);

CREATE TABLE IF NOT EXISTS RELAFFIL_TABLE (
	ID			int			NOT NULL UNIQUE PRIMARY KEY,
	affil		int			NOT NULL UNIQUE,			
    affil_name	varchar(64)	NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS SCHOOL_RELAFFIL (
	school_id		int		NOT NULL UNIQUE,
    affil_id		int		NOT NULL,
    PRIMARY KEY (school_id, affil_id),
    FOREIGN KEY (school_id)	REFERENCES SCHOOL_TABLE (ID),
    FOREIGN KEY (affil_id) REFERENCES RELAFFIL_TABLE (ID)
);

CREATE TABLE IF NOT EXISTS PER_FTE_TABLE (
	ID					int		NOT NULL UNIQUE PRIMARY KEY,
    net_tuition_revenue	int		NOT NULL,
    instruct_expend		int		NOT NULL,
    UNIQUE (net_tuition_revenue, instruct_expend)
); 

CREATE TABLE IF NOT EXISTS SCHOOL_PER_FTE (
	school_id		int		NOT NULL UNIQUE,
    per_fte_id		int		NOT NULL,
    PRIMARY KEY (school_id, per_fte_id),
    FOREIGN KEY (school_id) REFERENCES SCHOOL_TABLE (ID),
    FOREIGN KEY (per_fte_id) REFERENCES PER_FTE_TABLE (ID)
);

CREATE TABLE IF NOT EXISTS FACULTY_INFO (
	ID					int		NOT NULL UNIQUE PRIMARY KEY,
    avg_salary			int		NOT NULL,
    full_time_share		float	NOT NULL,
    UNIQUE (avg_salary, full_time_share)
);

CREATE TABLE IF NOT EXISTS SCHOOL_FACULTY_INFO (
	school_id		int		NOT NULL UNIQUE,
    faculty_id		int		NOT NULL,
    PRIMARY KEY (school_id, faculty_id),
    FOREIGN KEY (school_id) REFERENCES SCHOOL_TABLE (ID),
    FOREIGN KEY (faculty_id) REFERENCES PER_FTE_TABLE (ID)
);

CREATE TABLE IF NOT EXISTS ALIAS_NAME_TABLE (
	ID			int				NOT NULL UNIQUE PRIMARY KEY,
    alias_name	varchar(64)		UNIQUE
);

CREATE TABLE IF NOT EXISTS SCHOOL_ALIAS_NAME (
	school_id		int		NOT NULL UNIQUE,
    alias_id		int		NOT NULL,
    PRIMARY KEY (school_id, alias_id),
    FOREIGN KEY (school_id) REFERENCES SCHOOL_TABLE (ID),
    FOREIGN KEY (alias_id) REFERENCES ALIAS_NAME_TABLE (ID)
);

CREATE TABLE IF NOT EXISTS INSTITUTE_LEVEL_TABLE (
	ID			int		NOT NULL UNIQUE PRIMARY KEY,
    insti_level	int		NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS SCHOOL_INSTITUTE_LEVEL (
	school_id			int		NOT NULL UNIQUE,
    insti_level_id		int		NOT NULL,
    PRIMARY KEY (school_id, insti_level_id),
    FOREIGN KEY (school_id) REFERENCES SCHOOL_TABLE (ID),
    FOREIGN KEY (insti_level_id) REFERENCES INSTITUTE_LEVEL_TABLE (ID)
);

CREATE TABLE IF NOT EXISTS APPROVAL_DATE_TABLE (
	ID		int		NOT NULL UNIQUE PRIMARY KEY,
    _date	date	NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS SCHOOL_APPROVAL_DATE (
	school_id			int		NOT NULL UNIQUE,
    approval_date_id		int		NOT NULL,
    PRIMARY KEY (school_id, approval_date_id),
    FOREIGN KEY (school_id) REFERENCES SCHOOL_TABLE (ID),
    FOREIGN KEY (approval_date_id) REFERENCES APPROVAL_DATE_TABLE (ID)
);