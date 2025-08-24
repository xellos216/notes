# 어노테이션 정리

## 1. `@Bean`

* **설명**: Spring 컨테이너에 수동으로 Bean 등록을 위한 메서드에 사용.
* **calendar/config/FilterConfig.java**

```
@Bean
    public FilterRegistrationBean<AuthFilter> authFilterRegistration() {
        FilterRegistrationBean<AuthFilter> reg = new FilterRegistrationBean<>();
```

* **calendar/config/SecurityConfig.java**

```
@Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
```

---

## 2. `@Column`

* **설명**: JPA 엔티티 필드와 DB 컬럼을 매핑하고 속성을 지정.
* **calendar/entity/Comment.java**

```
@Column(length = 100, nullable = false)
    @Size(max = 100)
    private String contents;
```

* **calendar/entity/Schedule.java**

```
@Column(length = 30, nullable = false)
    @Size(max = 30)
    private String title;
```

---

## 3. `@Configuration`

* **설명**: 스프링 설정 클래스임을 명시.
* **calendar/config/JpaConfig.java**

```
@Configuration
@EnableJpaAuditing
public class JpaConfig { }
```

* **calendar/config/FilterConfig.java**

```
@Configuration
public class FilterConfig {
```

---

## 4. `@CreatedDate`

* **설명**: 엔티티 생성 시 자동으로 날짜/시간을 기록.
* **calendar/entity/BaseTimeEntity.java**

```
@CreatedDate
    @Column(name = "created_at", updatable = false, nullable = false)
    private LocalDateTime createdAt;
```

---

## 5. `@DeleteMapping`

* **설명**: HTTP DELETE 요청을 처리하는 메서드에 매핑.
* **calendar/controller/ScheduleController.java**

```
@DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        scheduleService.delete(id);
```

* **calendar/controller/CommentController.java**

```
@DeleteMapping("/comments/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id, HttpServletRequest req) {
        Long userId = requireSessionUserId(req);
```

---

## 6. `@Email`

* **설명**: 문자열이 이메일 형식인지 검증.
* **calendar/entity/User.java**

```
@Email
    @Column(nullable = false, unique = true)
    private String email;
```

---

## 7. `@EnableJpaAuditing`

* **설명**: JPA Auditing 기능을 활성화.
* **calendar/config/JpaConfig.java**

```
@Configuration
@EnableJpaAuditing
public class JpaConfig { }
```

---

## 8. `@Entity`

* **설명**: JPA 엔티티 클래스임을 명시.
* **calendar/entity/Schedule.java**

```
@Entity
public class Schedule extends BaseTimeEntity {
```

---

## 9. `@EntityListeners`

* **설명**: 엔티티 변경 이벤트를 처리할 리스너 지정.
* **calendar/entity/BaseTimeEntity.java**

```
@EntityListeners(AuditingEntityListener.class)
public abstract class BaseTimeEntity {
```

---

## 10. `@ExceptionHandler`

* **설명**: 특정 예외를 처리하는 메서드 지정.
* **calendar/controller/GlobalExceptionHandler.java**

```
@ExceptionHandler(IllegalArgumentException.class)
    public ResponseEntity<String> handleIllegalArgument(IllegalArgumentException e) {
```

---

## 11. `@ForeignKey`

* **설명**: 외래 키 제약조건을 지정.
* **calendar/entity/Comment.java**

```
@JoinColumn(name = "user_id", nullable = false, foreignKey = @ForeignKey(ConstraintMode.NO_CONSTRAINT))
```

---

## 12. `@GeneratedValue`

* **설명**: 기본 키 생성 전략 지정.
* **calendar/entity/User.java**

```
@Id
@GeneratedValue(strategy = GenerationType.IDENTITY)
private Long id;
```

---

## 13. `@GetMapping`

* **설명**: HTTP GET 요청을 처리하는 메서드에 매핑.
* **calendar/controller/UserController.java**

```
@GetMapping("/{id}")
    public ResponseEntity<UserResponseDto> getUser(@PathVariable Long id) {
```

---

## 14. `@Getter`

* **설명**: Lombok이 getter 메서드를 자동 생성.
* **calendar/entity/User.java**

```
@Getter
@Entity
public class User {
```

---

## 15. `@Id`

* **설명**: JPA 엔티티의 기본 키 지정.
* **calendar/entity/User.java**

```
@Id
@GeneratedValue(strategy = GenerationType.IDENTITY)
private Long id;
```

---

## 16. `@Index`

* **설명**: DB 인덱스 지정.
* **calendar/entity/Schedule.java**

```
@Table(indexes = @Index(name = "idx_user_id", columnList = "user_id"))
```

---

## 17. `@JoinColumn`

* **설명**: 조인 컬럼 지정 (외래 키 매핑).
* **calendar/entity/Comment.java**

```
@ManyToOne
@JoinColumn(name = "schedule_id", nullable = false)
private Schedule schedule;
```

---

## 18. `@LastModifiedDate`

* **설명**: 엔티티 수정 시 날짜/시간을 자동 기록.
* **calendar/entity/BaseTimeEntity.java**

```
@LastModifiedDate
@Column(name = "modified_at")
private LocalDateTime modifiedAt;
```

---

## 19. `@ManyToOne`

* **설명**: 다대일 관계 매핑.
* **calendar/entity/Comment.java**

```
@ManyToOne
@JoinColumn(name = "user_id", nullable = false)
private User user;
```

---

## 20. `@MappedSuperclass`

* **설명**: 공통 매핑 정보를 부모 클래스에 정의.
* **calendar/entity/BaseTimeEntity.java**

```
@MappedSuperclass
public abstract class BaseTimeEntity {
```

---

## 21. `@NotBlank`

* **설명**: 문자열이 null이 아니고, 공백이 아닌지 검증.
* **calendar/entity/User.java**

```
@NotBlank
@Column(nullable = false)
private String name;
```

---

## 22. `@NotNull`

* **설명**: 값이 null이 아닌지 검증.
* **calendar/entity/Schedule.java**

```
@NotNull
@Column(nullable = false)
private LocalDate date;
```

---

## 23. `@Override`

* **설명**: 부모 클래스/인터페이스 메서드를 재정의.
* **calendar/service/ScheduleService.java**

```
@Override
public void delete(Long id) {
```

---

## 24. `@PathVariable`

* **설명**: URL 경로 변수를 메서드 매개변수로 바인딩.
* **calendar/controller/ScheduleController.java**

```
@GetMapping("/{id}")
public ResponseEntity<ScheduleResponseDto> getSchedule(@PathVariable Long id) {
```

---

## 25. `@PostMapping`

* **설명**: HTTP POST 요청을 처리하는 메서드에 매핑.
* **calendar/controller/UserController.java**

```
@PostMapping
public ResponseEntity<UserResponseDto> createUser(@Valid @RequestBody UserRequestDto dto) {
```

---

## 26. `@PutMapping`

* **설명**: HTTP PUT 요청을 처리하는 메서드에 매핑.
* **calendar/controller/ScheduleController.java**

```
@PutMapping("/{id}")
public ResponseEntity<ScheduleResponseDto> update(@PathVariable Long id, @Valid @RequestBody ScheduleRequestDto dto) {
```

---

## 27. `@Query`

* **설명**: 사용자 정의 JPQL 또는 네이티브 쿼리 작성.
* **calendar/repository/UserRepository.java**

```
@Query("SELECT u FROM User u WHERE u.email = :email")
Optional<User> findByEmail(@Param("email") String email);
```

---

## 28. `@RequestBody`

* **설명**: HTTP 요청 본문(JSON 등)을 객체로 변환.
* **calendar/controller/UserController.java**

```
@PostMapping
public ResponseEntity<UserResponseDto> createUser(@Valid @RequestBody UserRequestDto dto) {
```

---

## 29. `@RequestMapping`

* **설명**: 클래스나 메서드의 요청 경로를 매핑.
* **calendar/controller/UserController.java**

```
@RestController
@RequestMapping("/api/users")
public class UserController {
```

---

## 30. `@RequestParam`

* **설명**: HTTP 요청 파라미터를 메서드 매개변수로 바인딩.
* **calendar/controller/ScheduleController.java**

```
@GetMapping("/page")
public ResponseEntity<List<ScheduleResponseDto>> getSchedules(@RequestParam int page) {
```

---

## 31. `@RestController`

* **설명**: REST API 컨트롤러 선언.
* **calendar/controller/ScheduleController.java**

```
@RestController
@RequestMapping("/api/schedules")
public class ScheduleController {
```

---

## 32. `@RestControllerAdvice`

* **설명**: 전역 예외 처리 및 컨트롤러 조언 클래스 선언.
* **calendar/controller/GlobalExceptionHandler.java**

```
@RestControllerAdvice
public class GlobalExceptionHandler {
```

---

## 33. `@Service`

* **설명**: 서비스 계층 클래스 선언.
* **calendar/service/ScheduleService.java**

```
@Service
public class ScheduleService {
```

---

## 34. `@Size`

* **설명**: 문자열/컬렉션의 길이 제한.
* **calendar/entity/Comment.java**

```
@Size(max = 100)
@Column(length = 100, nullable = false)
private String contents;
```

---

## 35. `@SpringBootApplication`

* **설명**: Spring Boot 애플리케이션 진입점.
* **calendar/CalendarApplication.java**

```
@SpringBootApplication
public class CalendarApplication {
```

---

## 36. `@Table`

* **설명**: 엔티티와 매핑될 DB 테이블 지정.
* **calendar/entity/Schedule.java**

```
@Entity
@Table(name = "schedules")
public class Schedule {
```

---

## 37. `@Transactional`

* **설명**: 트랜잭션 범위 지정.
* **calendar/service/ScheduleService.java**

```
@Transactional
public void update(Long id, ScheduleRequestDto dto) {
```

---

## 38. `@Valid`

* **설명**: 중첩 객체 유효성 검증 활성화.
* **calendar/controller/UserController.java**

```
@PostMapping
public ResponseEntity<UserResponseDto> createUser(@Valid @RequestBody UserRequestDto dto) {
```
