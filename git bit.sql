
CREATE NOTIFICATION INTEGRATION my_email_int
  TYPE=EMAIL
  ENABLED=TRUE
  DEFAULT_RECIPIENTS = ('kalivarunreddi@gmail.com')
  DEFAULT_SUBJECT = 'Service status';


  CREATE or replace TASK dw.email
  WAREHOUSE = COMPUTE_WH
  after dw.task_match_innings
as  

  CALL SYSTEM$SEND_EMAIL(
   'my_email_int', -- Notification Integration
   'kalivarunreddi@gmail.com', -- Recipients List
   'Snowflake Email Alert', -- Email Subject
   'This is a test Message.\nFrom Snowflake' -- Email Content
);
create or replace secret git_secret1
Type = password
USERNAME = "kalivarunreddi@gmail.com"
PASSWORD = "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"


CREATE OR REPLACE API INTEGRATION git_api_integration_snowflake
  API_PROVIDER = git_https_api
  API_ALLOWED_PREFIXES = ('https://github.com/')
  ALLOWED_AUTHENTICATION_SECRETS = (git_secret1)
  ENABLED = TRUE;


  show secrets

  show api integrations

  create or replace git repository my_git_snowflake
  api_integration = git_api_integration_snowflake
  GIT_CREDENTIALS=git_secret1
  ORIGIN="https://github.com/Kalivarun-hub/Snowflake-Demo.git"








  -- drop secret my_github_secret;

-- role to be changed...
show api integrations;
show integrations;

create or replace git repository my_github_repo
    api_integration = my_git_api_integration
    git_credentials = my_github_secret
    origin = 'https://github.com/DataEngineeringSimplified/my-private-repo';

    -- https://github.com/DataEngineeringSimplified/my-private-repo

-- show all git integration
show git repositories;

-- 
show git branches in git repository my_github_repo;


use role accountadmin;

-- not needed
-- create or replace secret my_github_secret

-- create integration object with public object
create or replace api integration my_public_git_api_integration
    api_provider = git_https_api
    api_allowed_prefixes = ('https://github.com/DataEngineeringSimplified/')
    enabled = true;

create or replace git repository my_github_public_repo
    api_integration = my_public_git_api_integration
    origin = 'https://github.com/DataEngineeringSimplified/<repo-name>';

    -- https://github.com/DataEngineeringSimplified/my-public-repo



    -- switch context
use role accountadmin;
use database demo;
use schema public;

-- describe
desc git repository my_github_repo;

-- show branches
show git branches in git repository my_git_snowflake;
    -- alternative command
    ls @my_git_snowflake/branches/Develop;

-- show tags
show git tags in git repository my_github_repo;
    -- List all files under the tag
    ls @my_github_repo/tags/<tag-name>;

-- fetch files based on commit hash code.
ls @my_github_repo/commits/a5ab4598401ff09fd6dbf7a8a1fdc4d4af3fe7ac;

-- fetch the lastest code
alter git repository my_github_repo fetch;
    -- Lets make a change and see how it work.
    -- does it fetch only the main branch or all..



    -- fetch files based on commit hash code.
ls @my_github_repo/commits/72fd17a0187e5530535e2cf71325dd6ec26e77ba0;

-- fetch the lastest code
alter git repository my_github_repo fetch;
    -- Lets make a change and see how it work.
    -- does it fetch only the main branch or all..

-- check the role and RBAC
use role public;
drop git repository my_github_public_repo;  -- make sure you must have owner's role
show git repositories;

use role accountadmin;

alter git repository my_github_repo set
    comment = 'this is my non-prod demo repository';

desc git repository my_github_repo;

create tag team_tag
    allowed_values 'HR', 'Finance';

alter git repository my_github_repo set
    tag team_tag = 'Finance';



    
execute immediate from @my_github_repo/branches/feature-external-table/sql-script/V1__INVENTORY_TABLE_DDL.SQL;
execute immediate from @my_github_repo/branches/feature-external-table/sql-script/V2__FILE_FORMAT_DDL.SQL;
execute immediate from @my_github_repo/branches/feature-external-table/sql-script/V3__STAGE_DDL.SQL;
execute immediate from @my_github_repo/branches/feature-external-table/sql-script/V4__COPY_STMT.SQL;
execute immediate from @my_github_repo/branches/feature-external-table/sql-script/V5__STREAM_DDL.SQL;

-- check case sensitivity
desc git repository tutorial;



desc table inventory;

insert into inventory
values
    (1,1,current_date(),'Hello-01'),
    (2,2,current_date(),'Hello-02'),
    (3,3,current_date(),'Hello-03'),
    (4,-1,current_date(),'Hello-04'),
    (5,-2,current_date(),'Hello-05');

select * from inventory where column3 = 'Hello-05';

alter git repository my_github_repo fetch;

ls @my_github_repo/branches/main;

-- no need to call it..
-- execute immediate from @my_github_repo/branches/main/python-script/filter.py;

execute immediate from @my_github_repo/branches/main/sql-script/V7__CREATE_SP.SQL;

call filter_by_column_value('INVENTORY', 'Hello-05');




--git clone https://dataengineeringsimplified-admin@bitbucket.org/dataengineeringsimplified/my-private-repo.git
git config user.email 4nnm141dt2dh5b0il7i9zwsu7k348l@bots.bitbucket.org
git clone https://bitsfdt-admin@bitbucket.org/my_private_demo/my_private_demo.git
-- create a secure object
create or replace secret my_bitbucket_secret
  type = password
  username = '<bitbucket id>' -- to be fetched
  password = '<token>'; -- ATBBpLq9C6bwhU9wDguRnxLafyJ199454C2

-- display all the secret objects
show secrets;

-- create integration object with secure object
create or replace api integration my_private_bitbucket_api_integration
  api_provider = git_https_api
  api_allowed_prefixes = ('https://bitbucket.org/dataengineeringsimplified/')
  allowed_authentication_secrets = (my_bitbucket_secret)
  enabled = true;

-- create a private repo by referring the repo name
create or replace git repository my_private_bitbucket_repo
  api_integration = my_private_bitbucket_api_integration
  git_credentials = my_bitbucket_secret
  origin = 'https://bitbucket.org/dataengineeringsimplified/my-testing-repo.git';

-- show all git integration
show git repositories;


git clone https://dataengineeringsimplified-admin@bitbucket.org/dataengineeringsimplified/my-private-repo.git
-- create a secure object
create or replace secret my_bitbucket_secret
  type = password
  username = '<bitbucket id>' -- to be fetched
  password = '<token>'; -- ATBBpLq9C6bwhU9wDguRnxLafyJ199454C2

-- display all the secret objects
show secrets;

-- create integration object with secure object
create or replace api integration my_private_bitbucket_api_integration
  api_provider = git_https_api
  api_allowed_prefixes = ('https://bitbucket.org/dataengineeringsimplified/')
  allowed_authentication_secrets = (my_bitbucket_secret)
  enabled = true;

-- create a private repo by referring the repo name
create or replace git repository my_private_bitbucket_repo
  api_integration = my_private_bitbucket_api_integration
  git_credentials = my_bitbucket_secret
  origin = 'https://bitbucket.org/dataengineeringsimplified/my-testing-repo.git';

-- show all git integration
show git repositories;




-- check how many tables we have in demo db + bitbucket schema
show tables;

--desc table to see the structure
desc table inventory;

-- insert some sample data
insert into inventory
values
  (1,1,current_date(),'Product-01'),
  (2,2,current_date(),'Product-02'),
  (3,3,current_date(),'Product-03'),
  (4,-1,current_date(),'Product-04'),
  (5,-2,current_date(),'Product-05');

-- run select stmt
select * from inventory where column3 = 'Product-05';

-- pull the repo
alter git repository my_github_repo fetch;

-- list all files
ls @my_private_bitbucket_repo/branches/main;

-- no need to call it..
-- execute immediate from @my_github_repo/branches/main/python-script/filter.py;

