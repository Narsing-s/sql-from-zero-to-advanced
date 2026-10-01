DROP TABLE IF EXISTS lab_jobs;
CREATE TABLE lab_jobs (
  job_id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  payload jsonb NOT NULL,
  status text NOT NULL DEFAULT 'ready' CHECK (status IN ('ready','running','done','failed')),
  attempts integer NOT NULL DEFAULT 0,
  available_at timestamptz NOT NULL DEFAULT now(),
  locked_at timestamptz
);
INSERT INTO lab_jobs(payload)
SELECT jsonb_build_object('task','demo','n',g) FROM generate_series(1,10) g;

WITH next_job AS (
  SELECT job_id FROM lab_jobs
  WHERE status='ready' AND available_at <= now()
  ORDER BY job_id FOR UPDATE SKIP LOCKED LIMIT 1
)
UPDATE lab_jobs j
SET status='running', attempts=attempts+1, locked_at=clock_timestamp()
FROM next_job
WHERE j.job_id=next_job.job_id
RETURNING j.*;

SELECT pg_try_advisory_lock(9001) AS acquired;
SELECT pg_advisory_unlock(9001) AS released;

-- DROP TABLE lab_jobs;