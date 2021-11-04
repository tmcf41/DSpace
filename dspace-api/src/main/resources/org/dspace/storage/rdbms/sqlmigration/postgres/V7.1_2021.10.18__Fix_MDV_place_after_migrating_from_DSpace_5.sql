--
-- The contents of this file are subject to the license and copyright
-- detailed in the LICENSE and NOTICE files at the root of the source
-- tree and available online at
--
-- http://www.dspace.org/license/
--

----------------------------------------------------
-- Make sure the metadatavalue.place column starts at 0 instead of 1
----------------------------------------------------
UPDATE metadatavalue AS mdv
SET place = mdv.place - minplace
FROM (
       SELECT dspace_object_id, metadata_field_id, MIN(place) AS minplace
       FROM metadatavalue
       GROUP BY dspace_object_id, metadata_field_id
     ) AS mp
WHERE mdv.dspace_object_id = mp.dspace_object_id
  AND mdv.metadata_field_id = mp.metadata_field_id
  AND minplace > 0;
