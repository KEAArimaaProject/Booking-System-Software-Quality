import { test, expect } from '@playwright/test';

test.describe('API testing - Activities', () => {
    test('GET /api/activities returns activities list', async ({ request }) => {

        const response = await request.get('/api/activities');

        expect(response.status()).toBe(200);

        const body = await response.json();

        expect(Array.isArray(body)).toBeTruthy();
        expect(body.length).toBeGreaterThan(0);

        expect(body[0]).toHaveProperty('id');
        expect(body[0]["id"]).toEqual(expect.any(Number));
        expect(body[0]).toHaveProperty('name');
        expect(body[0]["name"]).toEqual(expect.any(String));
        expect(body[0]).toHaveProperty('description');
        expect(body[0]["description"]).toEqual(expect.any(String));
        expect(body[0]).toHaveProperty('location');
        expect(body[0]["location"]).toEqual(expect.any(String));
        expect(body[0]).toHaveProperty('maxParticipants');
        expect(body[0]["maxParticipants"]).toEqual(expect.any(Number));
    });

    test('GET /api/activities/{activityId}/slots returns available slots for valid activity and date', async ({ request }) => {
        const fullstartdate = getFutureDate(5, 10)
        const startday = getDayFromDate(fullstartdate);
        const activityid = 1;

        const response = await request.get(`/api/activities/${activityid}/slots?date=${startday}`);


        expect(response.status()).toBe(200);

        const body = await response.json();

        expect(body).toHaveProperty('activityId', activityid);
        expect(body).toHaveProperty('date', startday);
        expect(body).toHaveProperty('availableSlots');
        expect(Array.isArray(body.availableSlots)).toBeTruthy();
        expect(body.availableSlots).toEqual([
            "10:00:00",
            "12:00:00",
            "14:00:00",
            "16:00:00",
            "18:00:00"
        ]);
    });

    function getDayFromDate(date) {
        return date.toISOString().split('T')[0];
    }

    function  getFutureDate(daysAhead, wholehour): Date {
        const date = new Date();

        date.setDate(date.getDate() + daysAhead);
        date.setHours(wholehour, 0, 0, 0);

        return date;
    }
});