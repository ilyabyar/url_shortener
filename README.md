The application has been deployed to heroku [https://peaceful-ravine-17683.herokuapp.com/](https://peaceful-ravine-17683.herokuapp.com/)
It uses free tiers for PostgreSQL and Redis.

Install ruby, redis, postgresql, all gems. Create database and run seeds.
Use `rails s` for running rails server
Execute `sidekiq` for running background jobs

## Went well
- Challenging task
- All the task requirements were fullfilled

## Didn't went well
- Nothing I would put here

## If I had more time to work on this, I would ...
- Improve frontend part for a list of links. Using react-table would make it more flexible and     robust. This could also easily help  to add a pagination. 
- Make better frontend side with using the most wideused React libraries
- Add ESLint
- Get advantage of using React Proptypes
- Setup nginx or CDN for fast aseets
- Setup rubocop additional extensions
- Setup CI for running tests, and other tools like ([Brakeman](https://github.com/presidentbeef/brakeman)]
- Covered it with rspec tests, according to testing pyramide
- Generate unique short digests in advance in the background(that could help us to avoid possible collision) and probably some fancy features like reserve some very short url(1-3 letters) for futher sell
- Tune Redis to be RDB and AOF persistent
- Tune redis & psql connection pool limit to handle more connections(now its limited by ree tiers)
- Make `RedisStatsWorker` idempotant. See its TODO inside
- Separate redis  for sidekiq, application cache and counter storage
- If there would be any rare issues with redis, I would create a worker for the future redis data restoring, accepting link_id , fetching(seee SQL attached) all needed data from SQL database - that we need for  redis(total num of rows and attendances, uniq  attendances). After getting all data we need, I would sync it to back Redis.
 
` SELECT countries.name as country_name,
	   array_length(array_agg(DISTINCT ip), 1),
	   COUNT(attendances.id) as attendance_count
FROM attendances
INNER JOIN countries ON countries.id = attendances.country_id
WHERE link_id = #{link_id}
GROUP BY countries.id;`

Though, this approach will require some blockings in order to be thread-safe

- Track uniq visitors using cookie(GDPR popup required!)
- Think about scaling - alternatives DBMS like NoSQL - they are easier to scale.
- Setting up replicas for further scalability. Using some other techniques, like partitioning. 
- Think about removing old links(more than X years ago and visited not more that Y times - that could help us to free a lot of space)

 


 
