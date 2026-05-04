export declare class SubmitExerciseDto {
    exerciseId: string;
    answers?: Record<string, number | string>;
    answer?: string | string[] | number;
    taskId?: string;
    planId?: string;
    activityId?: string;
}
