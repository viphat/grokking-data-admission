-- Using Postgresql

-- Function isFirstTimeBuyer

CREATE OR REPLACE FUNCTION isFirstTimeBuyer(uid int, m timestamp without time zone)
RETURNS integer AS $$
	BEGIN
    	IF (EXISTS (SELECT user_id FROM purchases WHERE user_id = uid AND date_trunc('month', created_at) = date_trunc('month', m))
           	AND NOT EXISTS (SELECT user_id FROM purchases WHERE user_id = uid AND date_trunc('month', created_at) < date_trunc('month', m))
           ) THEN
            RETURN 1;
        END IF;
       	RETURN 0;
    END
$$ LANGUAGE plpgsql;

-- Function isReturnedBuyer?

CREATE OR REPLACE FUNCTION isReturnedBuyer(uid int, m timestamp without time zone)
RETURNS integer AS $$
	BEGIN
    	IF (EXISTS (SELECT user_id FROM purchases WHERE user_id = uid AND date_trunc('month', created_at) = date_trunc('month', m))
            AND isFirstTimeBuyer(uid, m) = 0) THEN
            RETURN 1;
        END IF;
    	RETURN 0;
   	END
$$ LANGUAGE plpgsql;

-- Challenge 3 Main Query

SELECT date_trunc('month', created_at) as month,
sum(isFirstTimeBuyer(user_id, date_trunc('month',created_at))) As first_time_buyers,
sum(isReturnedBuyer(user_id, date_trunc('month',created_at))) As returned_buyers
FROM (
 SELECT distinct user_id, date_trunc('month', created_at) as created_at
 FROM purchases
) as p
GROUP BY date_trunc('month', created_at)
ORDER BY date_trunc('month', created_at);
