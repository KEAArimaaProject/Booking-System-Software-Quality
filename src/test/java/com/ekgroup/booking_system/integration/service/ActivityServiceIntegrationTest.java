package com.ekgroup.booking_system.integration.service;

import com.ekgroup.booking_system.dto.TimeSlotResponse;
import com.ekgroup.booking_system.service.ActivityService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.MethodSource;
import org.junit.jupiter.params.provider.ValueSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.stream.Stream;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
class ActivityServiceIntegrationTest {

    @Autowired
    private ActivityService activityService;

    private List<LocalTime> expectedSlots;

    @BeforeEach
    void setUp() {
        expectedSlots = List.of(
                LocalTime.of(10, 0),
                LocalTime.of(12, 0),
                LocalTime.of(14, 0),
                LocalTime.of(16, 0),
                LocalTime.of(18, 0)
        );
    }

    @ParameterizedTest
    @MethodSource("provideDatesForActivity1")
    void getAvailableSlots_variousDates_activityId1(LocalDate testDate) {
        long activityId = 1L;

        TimeSlotResponse slots = activityService.getAvailableSlots(activityId, testDate);

        assertThat(slots.activityId()).isEqualTo(activityId);
        assertThat(slots.date()).isEqualTo(testDate);
        assertThat(slots.availableSlots()).isEqualTo(expectedSlots);
    }

    static Stream<LocalDate> provideDatesForActivity1() {
        return Stream.of(
                LocalDate.now().minusDays(1200),
                LocalDate.now().minusDays(2),
                LocalDate.now().minusDays(1),
                LocalDate.now(),
                LocalDate.now().plusDays(1),
                LocalDate.now().plusDays(2),
                LocalDate.now().plusDays(5),
                LocalDate.now().plusDays(1200)
        );
    }

    @ParameterizedTest
    @ValueSource(longs = {1L, 2L, 3L, 4L})
    void getAvailableSlots_variousActivities_inFiveDays(long activityId) {
        LocalDate testDate = LocalDate.now().plusDays(5);

        TimeSlotResponse slots = activityService.getAvailableSlots(activityId, testDate);

        assertThat(slots.activityId()).isEqualTo(activityId);
        assertThat(slots.date()).isEqualTo(testDate);
        assertThat(slots.availableSlots()).isEqualTo(expectedSlots);
    }

}
