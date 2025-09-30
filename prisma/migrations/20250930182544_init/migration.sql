-- CreateTable
CREATE TABLE "department" (
    "dept_id" VARCHAR(10) NOT NULL,
    "dept_name" VARCHAR(100) NOT NULL,
    "building_no" VARCHAR(20),

    CONSTRAINT "department_pkey" PRIMARY KEY ("dept_id")
);

-- CreateTable
CREATE TABLE "room" (
    "room_id" VARCHAR(10) NOT NULL,
    "room_number" VARCHAR(20) NOT NULL,
    "capacity" INTEGER,
    "type" VARCHAR(50),
    "dept_id" VARCHAR(10),

    CONSTRAINT "room_pkey" PRIMARY KEY ("room_id")
);

-- CreateTable
CREATE TABLE "faculty" (
    "faculty_id" VARCHAR(10) NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "position" VARCHAR(50),
    "email" VARCHAR(100),
    "password" VARCHAR(255) NOT NULL,
    "office" VARCHAR(50),
    "room_id" VARCHAR(10),

    CONSTRAINT "faculty_pkey" PRIMARY KEY ("faculty_id")
);

-- CreateTable
CREATE TABLE "student" (
    "id" VARCHAR(10) NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "level" VARCHAR(20),
    "status" VARCHAR(20),
    "email" VARCHAR(100),
    "password" VARCHAR(255) NOT NULL,
    "dept_id" VARCHAR(10),
    "advisor_id" VARCHAR(10),

    CONSTRAINT "student_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "course" (
    "course_id" VARCHAR(10) NOT NULL,
    "course_code" VARCHAR(20) NOT NULL,
    "course_name" VARCHAR(150) NOT NULL,
    "course_type" VARCHAR(50),
    "dept_id" VARCHAR(10),

    CONSTRAINT "course_pkey" PRIMARY KEY ("course_id")
);

-- CreateTable
CREATE TABLE "committee" (
    "committee_id" VARCHAR(10) NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "rule_type" VARCHAR(50),
    "email" VARCHAR(100),
    "password" VARCHAR(255) NOT NULL,

    CONSTRAINT "committee_pkey" PRIMARY KEY ("committee_id")
);

-- CreateTable
CREATE TABLE "rule" (
    "rule_id" VARCHAR(10) NOT NULL,
    "rule_name" VARCHAR(100) NOT NULL,
    "rule_description" TEXT,
    "rule_type" VARCHAR(50),
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "priority_level" INTEGER,
    "created_by" VARCHAR(100),
    "modified_date" DATE,
    "committee_id" VARCHAR(10),

    CONSTRAINT "rule_pkey" PRIMARY KEY ("rule_id")
);

-- CreateTable
CREATE TABLE "schedule" (
    "schedule_id" VARCHAR(10) NOT NULL,
    "version_number" INTEGER NOT NULL,
    "semester" VARCHAR(20) NOT NULL,
    "year" INTEGER NOT NULL,
    "status" VARCHAR(20),
    "created_date" DATE,

    CONSTRAINT "schedule_pkey" PRIMARY KEY ("schedule_id")
);

-- CreateTable
CREATE TABLE "timeslot" (
    "timeslot_id" VARCHAR(10) NOT NULL,
    "day_of_week" VARCHAR(20) NOT NULL,
    "start_time" TIME NOT NULL,
    "end_time" TIME NOT NULL,
    "course_id" VARCHAR(10),

    CONSTRAINT "timeslot_pkey" PRIMARY KEY ("timeslot_id")
);

-- CreateTable
CREATE TABLE "section" (
    "course_id" VARCHAR(10) NOT NULL,
    "section_number" VARCHAR(10) NOT NULL,
    "max_enrollment" INTEGER,
    "current_enrollment" INTEGER DEFAULT 0,
    "room_id" VARCHAR(10),
    "faculty_id" VARCHAR(10),

    CONSTRAINT "section_pkey" PRIMARY KEY ("course_id","section_number")
);

-- CreateTable
CREATE TABLE "exam" (
    "course_id" VARCHAR(10) NOT NULL,
    "exam_type" VARCHAR(50) NOT NULL,
    "exam_date" DATE,

    CONSTRAINT "exam_pkey" PRIMARY KEY ("course_id","exam_type")
);

-- CreateTable
CREATE TABLE "affiliated_with" (
    "dept_id" VARCHAR(10) NOT NULL,
    "faculty_id" VARCHAR(10) NOT NULL,

    CONSTRAINT "affiliated_with_pkey" PRIMARY KEY ("dept_id","faculty_id")
);

-- CreateTable
CREATE TABLE "enrolls" (
    "student_id" VARCHAR(10) NOT NULL,
    "course_id" VARCHAR(10) NOT NULL,
    "section_number" VARCHAR(10) NOT NULL,

    CONSTRAINT "enrolls_pkey" PRIMARY KEY ("student_id","course_id","section_number")
);

-- CreateTable
CREATE TABLE "scheduled_at" (
    "course_id" VARCHAR(10) NOT NULL,
    "section_number" VARCHAR(10) NOT NULL,
    "timeslot_id" VARCHAR(10) NOT NULL,

    CONSTRAINT "scheduled_at_pkey" PRIMARY KEY ("course_id","section_number","timeslot_id")
);

-- CreateTable
CREATE TABLE "contains" (
    "schedule_id" VARCHAR(10) NOT NULL,
    "course_id" VARCHAR(10) NOT NULL,

    CONSTRAINT "contains_pkey" PRIMARY KEY ("schedule_id","course_id")
);

-- CreateTable
CREATE TABLE "feedback_student" (
    "student_id" VARCHAR(10) NOT NULL,
    "schedule_id" VARCHAR(10) NOT NULL,

    CONSTRAINT "feedback_student_pkey" PRIMARY KEY ("student_id","schedule_id")
);

-- CreateTable
CREATE TABLE "feedback_faculty" (
    "faculty_id" VARCHAR(10) NOT NULL,
    "schedule_id" VARCHAR(10) NOT NULL,

    CONSTRAINT "feedback_faculty_pkey" PRIMARY KEY ("faculty_id","schedule_id")
);

-- CreateTable
CREATE TABLE "prefers" (
    "student_id" VARCHAR(10) NOT NULL,
    "course_id" VARCHAR(10) NOT NULL,
    "preference_rank" INTEGER,
    "semester" VARCHAR(20),
    "status" VARCHAR(20),

    CONSTRAINT "prefers_pkey" PRIMARY KEY ("student_id","course_id")
);

-- CreateTable
CREATE TABLE "follows_rule" (
    "schedule_id" VARCHAR(10) NOT NULL,
    "rule_id" VARCHAR(10) NOT NULL,

    CONSTRAINT "follows_rule_pkey" PRIMARY KEY ("schedule_id","rule_id")
);

-- CreateTable
CREATE TABLE "requires" (
    "course_id" VARCHAR(10) NOT NULL,
    "prereq_course_id" VARCHAR(10) NOT NULL,

    CONSTRAINT "requires_pkey" PRIMARY KEY ("course_id","prereq_course_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "faculty_email_key" ON "faculty"("email");

-- CreateIndex
CREATE UNIQUE INDEX "student_email_key" ON "student"("email");

-- CreateIndex
CREATE UNIQUE INDEX "course_course_code_key" ON "course"("course_code");

-- CreateIndex
CREATE UNIQUE INDEX "committee_email_key" ON "committee"("email");

-- AddForeignKey
ALTER TABLE "room" ADD CONSTRAINT "room_dept_id_fkey" FOREIGN KEY ("dept_id") REFERENCES "department"("dept_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "faculty" ADD CONSTRAINT "faculty_room_id_fkey" FOREIGN KEY ("room_id") REFERENCES "room"("room_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "student" ADD CONSTRAINT "student_dept_id_fkey" FOREIGN KEY ("dept_id") REFERENCES "department"("dept_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "student" ADD CONSTRAINT "student_advisor_id_fkey" FOREIGN KEY ("advisor_id") REFERENCES "faculty"("faculty_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "course" ADD CONSTRAINT "course_dept_id_fkey" FOREIGN KEY ("dept_id") REFERENCES "department"("dept_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "rule" ADD CONSTRAINT "rule_committee_id_fkey" FOREIGN KEY ("committee_id") REFERENCES "committee"("committee_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "timeslot" ADD CONSTRAINT "timeslot_course_id_fkey" FOREIGN KEY ("course_id") REFERENCES "course"("course_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "section" ADD CONSTRAINT "section_course_id_fkey" FOREIGN KEY ("course_id") REFERENCES "course"("course_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "section" ADD CONSTRAINT "section_room_id_fkey" FOREIGN KEY ("room_id") REFERENCES "room"("room_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "section" ADD CONSTRAINT "section_faculty_id_fkey" FOREIGN KEY ("faculty_id") REFERENCES "faculty"("faculty_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "exam" ADD CONSTRAINT "exam_course_id_fkey" FOREIGN KEY ("course_id") REFERENCES "course"("course_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "affiliated_with" ADD CONSTRAINT "affiliated_with_dept_id_fkey" FOREIGN KEY ("dept_id") REFERENCES "department"("dept_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "affiliated_with" ADD CONSTRAINT "affiliated_with_faculty_id_fkey" FOREIGN KEY ("faculty_id") REFERENCES "faculty"("faculty_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "enrolls" ADD CONSTRAINT "enrolls_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "student"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "enrolls" ADD CONSTRAINT "enrolls_course_id_section_number_fkey" FOREIGN KEY ("course_id", "section_number") REFERENCES "section"("course_id", "section_number") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "scheduled_at" ADD CONSTRAINT "scheduled_at_course_id_section_number_fkey" FOREIGN KEY ("course_id", "section_number") REFERENCES "section"("course_id", "section_number") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "scheduled_at" ADD CONSTRAINT "scheduled_at_timeslot_id_fkey" FOREIGN KEY ("timeslot_id") REFERENCES "timeslot"("timeslot_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contains" ADD CONSTRAINT "contains_schedule_id_fkey" FOREIGN KEY ("schedule_id") REFERENCES "schedule"("schedule_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contains" ADD CONSTRAINT "contains_course_id_fkey" FOREIGN KEY ("course_id") REFERENCES "course"("course_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "feedback_student" ADD CONSTRAINT "feedback_student_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "student"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "feedback_student" ADD CONSTRAINT "feedback_student_schedule_id_fkey" FOREIGN KEY ("schedule_id") REFERENCES "schedule"("schedule_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "feedback_faculty" ADD CONSTRAINT "feedback_faculty_faculty_id_fkey" FOREIGN KEY ("faculty_id") REFERENCES "faculty"("faculty_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "feedback_faculty" ADD CONSTRAINT "feedback_faculty_schedule_id_fkey" FOREIGN KEY ("schedule_id") REFERENCES "schedule"("schedule_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "prefers" ADD CONSTRAINT "prefers_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "student"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "prefers" ADD CONSTRAINT "prefers_course_id_fkey" FOREIGN KEY ("course_id") REFERENCES "course"("course_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "follows_rule" ADD CONSTRAINT "follows_rule_schedule_id_fkey" FOREIGN KEY ("schedule_id") REFERENCES "schedule"("schedule_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "follows_rule" ADD CONSTRAINT "follows_rule_rule_id_fkey" FOREIGN KEY ("rule_id") REFERENCES "rule"("rule_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "requires" ADD CONSTRAINT "requires_course_id_fkey" FOREIGN KEY ("course_id") REFERENCES "course"("course_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "requires" ADD CONSTRAINT "requires_prereq_course_id_fkey" FOREIGN KEY ("prereq_course_id") REFERENCES "course"("course_id") ON DELETE CASCADE ON UPDATE CASCADE;
