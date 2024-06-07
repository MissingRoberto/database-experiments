\c containers_db;

-- Query to load the parents of container
WITH RECURSIVE ParentContainerCTE AS (
    SELECT 
        c1.id, 
        c1.name, 
        c1.parent_id,
        0 AS depth
    FROM 
        container c1 
    WHERE 
        c1.id = 4
    UNION ALL
    SELECT 
        c2.id, 
        c2.name, 
        c2.parent_id,
        pc.depth - 1 AS depth
    FROM 
        container c2 
    INNER JOIN 
        ParentContainerCTE pc 
    ON 
        c2.id = pc.parent_id
)
SELECT * FROM ParentContainerCTE where id != 4 ORDER BY depth ASC;


-- Query to get all children of a container
WITH RECURSIVE ChildContainerCTE AS (
    SELECT 
        c1.id, 
        c1.name, 
        c1.parent_id,
        0 as depth
    FROM 
        container c1 
    WHERE 
        c1.id = 1
    UNION ALL
    SELECT 
        c2.id, 
        c2.name, 
        c2.parent_id, 
        cc.depth + 1 as depth
    FROM 
        container c2 
    INNER JOIN 
        ChildContainerCTE cc 
    ON 
        c2.parent_id = cc.id
)
SELECT * FROM ChildContainerCTE where id !=1;



-- Query to load parents, the container and its children with a single query and its depth
WITH RECURSIVE Parents AS (
    SELECT 
        c1.id, 
        c1.name, 
        c1.parent_id,
        0 AS depth
    FROM
        container c1
    WHERE
        c1.id = 4
    UNION ALL
    SELECT 
        c2.id, 
        c2.name, 
        c2.parent_id,
        pc.depth - 1 AS depth
    FROM
        container c2
    INNER JOIN
        Parents pc
    ON  
        c2.id = pc.parent_id

), Children AS (
    SELECT 
        c1.id, 
        c1.name, 
        c1.parent_id,
        0 AS depth
    FROM
        container c1
    WHERE
        c1.id = 4
    UNION ALL
    SELECT 
        c2.id, 
        c2.name, 
        c2.parent_id,
        cc.depth + 1 AS depth
    FROM
        container c2
    INNER JOIN
        Children cc
    ON  
        c2.parent_id = cc.id
)

SELECT * FROM (
    SELECT * FROM Parents
    UNION ALL
    SELECT * FROM Children WHERE id != 4
) ORDER BY depth ASC;