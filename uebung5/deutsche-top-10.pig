-- load data

users_tracks_data = LOAD 'users_tracks_data.tsv' AS (user_id:chararray, country:chararray, gender:chararray, age:int, artist_name:chararray, track_name:chararray);

-- filter data

tracks_from_germany = FILTER users_tracks_data BY country == 'Germany';

-- group data

grouped_tracks = GROUP tracks_from_germany BY (artist_name, track_name);

-- count data

counted_tracks = FOREACH grouped_tracks GENERATE FLATTEN(group), COUNT(tracks_from_germany) AS count;

-- order data

ordered_tracks = ORDER counted_tracks BY count DESC;

-- get the top 10 and store it

top_10_tracks = LIMIT ordered_tracks 10;
STORE top_10_tracks INTO 'top_10_tracks.tsv';
