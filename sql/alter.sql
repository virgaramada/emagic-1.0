ALTER TABLE INV_MGT_OUTPUT MODIFY COLUMN OUTPUT_DATE DATE  NOT NULL;

-- 23/03/2011
ALTER TABLE INV_MGT_OUTPUT ADD COLUMN OUTPUT_TIME_SHIFT VARCHAR (10) NULL;
UPDATE INV_MGT_OUTPUT SET OUTPUT_TIME_SHIFT = '1' WHERE OUTPUT_TIME >=  6 AND OUTPUT_TIME < 14;
UPDATE INV_MGT_OUTPUT SET OUTPUT_TIME_SHIFT = '2' WHERE OUTPUT_TIME >=  14 AND OUTPUT_TIME < 22;
UPDATE INV_MGT_OUTPUT SET OUTPUT_TIME_SHIFT = '3' WHERE OUTPUT_TIME >=  22 AND OUTPUT_TIME < 6;
