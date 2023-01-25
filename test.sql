SELECT 
jobs.id AS 'Jobs__id',
jobs.name AS 'Jobs__name',
jobs.media_id AS 'Jobs__media_id',
jobs.job_category_id AS 'Jobs__job_category_id',
jobs.job_type_id AS 'Jobs__job_type_id',
jobs.description AS 'Jobs__description',
jobs.detail AS 'Jobs__detail',
jobs.business_skill AS 'Jobs__business_skill',
jobs.knowledge AS 'Jobs__knowledge',
jobs.location AS 'Jobs__location',
jobs.activity AS 'Jobs__activity',
jobs.academic_degree_doctor AS 'Jobs__academic_degree_doctor',
jobs.academic_degree_master AS 'Jobs__academic_degree_master',
jobs.academic_degree_professional AS 'Jobs__academic_degree_professional',
jobs.academic_degree_bachelor AS 'Jobs__academic_degree_bachelor',
jobs.salary_statistic_group AS 'Jobs__salary_statistic_group',
jobs.salary_range_first_year AS 'Jobs__salary_range_first_year',
jobs.salary_range_average AS 'Jobs__salary_range_average',
jobs.salary_range_remarks AS 'Jobs__salary_range_remarks',
jobs.restriction AS 'Jobs__restriction',
jobs.estimated_total_workers AS 'Jobs__estimated_total_workers',
jobs.remarks AS 'Jobs__remarks',
jobs.url AS 'Jobs__url',
jobs.seo_description AS 'Jobs__seo_description',
jobs.seo_keywords AS 'Jobs__seo_keywords',
jobs.sort_order AS 'Jobs__sort_order',
jobs.publish_status AS 'Jobs__publish_status',
jobs.version AS 'Jobs__version',
jobs.created_by AS 'Jobs__created_by',
jobs.created AS 'Jobs__created',
jobs.modified AS 'Jobs__modified',
jobs.deleted AS 'Jobs__deleted',
job_categories.id AS 'JobCategories__id',
job_categories.name AS 'JobCategories__name',
job_categories.sort_order AS 'JobCategories__sort_order',
job_categories.created_by AS 'JobCategories__created_by',
job_categories.created AS 'JobCategories__created',
job_categories.modified AS 'JobCategories__modified',
job_categories.deleted AS 'JobCategories__deleted',
job_types.id AS 'JobTypes__id',
job_types.name AS 'JobTypes__name',
job_types.job_category_id AS 'JobTypes__job_category_id',
job_types.sort_order AS 'JobTypes__sort_order',
job_types.created_by AS 'JobTypes__created_by',
job_types.created AS 'JobTypes__created',
job_types.modified AS 'JobTypes__modified',
job_types.deleted AS 'JobTypes__deleted'
from
(select id,name,media_id,job_category_id,job_type_id,description,detail,business_skill,knowledge,location,activity,
academic_degree_doctor,academic_degree_master,academic_degree_professional,academic_degree_bachelor,salary_statistic_group,
salary_range_first_year,salary_range_average,salary_range_remarks,restriction,estimated_total_workers,remarks,url,seo_description,
seo_keywords,sort_order,publish_status,version,created_by,created,modified,deleted
from jobs
where name LIKE '%キャビンアテンダント%' OR description LIKE '%キャビンアテンダント%' OR detail LIKE '%キャビンアテンダント%' OR business_skill LIKE '%キャビンアテンダント%' 
OR knowledge LIKE '%キャビンアテンダント%' OR location LIKE '%キャビンアテンダント%' OR activity LIKE '%キャビンアテンダント%' OR salary_statistic_group LIKE '%キャビンアテンダント%' 
OR salary_range_remarks LIKE '%キャビンアテンダント%' OR restriction LIKE '%キャビンアテンダント%' OR remarks LIKE '%キャビンアテンダント%') jobs
LEFT JOIN
(select personality_id,job_id from jobs_personalities) jobs_personalities 
ON jobs.id = jobs_personalities.job_id
LEFT JOIN
(select id,deleted from personalities where deleted IS NULL and name LIKE '%キャビンアテンダント%') personalities
ON personalities.id = jobs_personalities.personality_id AND personalities.deleted IS NULL
LEFT JOIN
(select practical_skill_id,job_id from jobs_practical_skills) jobs_practical_skills
ON jobs.id = jobs_practical_skills.job_id
LEFT JOIN
(select id,deleted from practical_skills where deleted IS NULL and name LIKE '%キャビンアテンダント%') practical_skills
ON practical_skills.id = jobs_practical_skills.practical_skill_id AND practical_skills.deleted IS NULL
LEFT JOIN
(select basic_ability_id,job_id from jobs_basic_abilities) jobs_basic_abilities
ON jobs.id = jobs_basic_abilities.job_id
LEFT JOIN
(select id,deleted from basic_abilities where deleted IS NULL and name LIKE '%キャビンアテンダント%') basic_abilities
ON basic_abilities.id = jobs_basic_abilities.basic_ability_id AND basic_abilities.deleted IS NULL
LEFT JOIN
(select affiliate_id,job_id from jobs_tools) jobs_tools
ON jobs.id = jobs_tools.job_id
LEFT JOIN
(select type,id,deleted from affiliates where type in (1,2,3) and deleted IS NULL AND (name LIKE '%キャビンアテンダント%'
OR name LIKE '%キャビンアテンダント%'
OR name LIKE '%キャビンアテンダント%' 
OR name LIKE '%キャビンアテンダント%')) affiliates 
ON affiliates.type = 1 AND affiliates.id = jobs_tools.affiliate_id AND affiliates.deleted IS NULL
LEFT JOIN 
(select affiliate_id,job_id from jobs_career_paths) jobs_career_paths
ON jobs.id = jobs_career_paths.job_id
LEFT JOIN
affiliates 
ON affiliates.type = 3 AND affiliates.id = jobs_career_paths.affiliate_id AND affiliates.deleted IS NULL
LEFT JOIN
(select affiliate_id,job_id from jobs_rec_qualifications) jobs_rec_qualifications
ON jobs.id = jobs_rec_qualifications.job_id
LEFT JOIN 
affiliates
ON affiliates.type = 2 AND affiliates.id = jobs_rec_qualifications.affiliate_id AND affiliates.deleted IS NULL
LEFT JOIN
(select affiliate_id,job_id from jobs_req_qualifications) jobs_req_qualifications
ON jobs.id = jobs_req_qualifications.job_id
LEFT JOIN 
affiliates
ON affiliates.type = 2 AND affiliates.id = jobs_req_qualifications.affiliate_id AND affiliates.deleted IS NULL
INNER JOIN
(select id,deleted,name,sort_order,created_by,created,modified,deleted from job_categories where deleted IS NULL and name LIKE '%キャビンアテンダント%') job_categories
ON job_categories.id = jobs.job_category_id AND job_categories.deleted IS NULL
INNER JOIN 
(select id,deleted,id,name,job_category_id,sort_order,created_by,created,modified,deleted from job_types where deleted IS NULL AND name LIKE '%キャビンアテンダント%') job_types
ON job_types.id = jobs.job_type_id AND job_types.deleted IS NULL
WHERE 
publish_status = 1 AND jobs.deleted IS NULL
GROUP BY jobs.id
ORDER BY jobs.sort_order desc, jobs.id DESC LIMIT 50 OFFSET 0


