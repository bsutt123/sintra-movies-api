CREATE TABLE entries (
       ttconst TEXT,
       title_type TEXT,
       primary_title TEXT,
       original_title TEXT,
       is_adult TEXT,
       start_year TEXT,
       end_year TEXT,
       runtime TEXT,
       genres TEXT
       );

.mode tabs
.import title.basics.tsv entries
