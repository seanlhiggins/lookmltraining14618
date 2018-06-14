view: users {
  sql_table_name: public.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    group_label: "Age"
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: age_tier {
    group_label: "Age"
    type: tier
    tiers: [10,20,30,50,90]
    sql: ${age} ;;
    style: integer
  }

  dimension: is_below_45 {
    group_label: "Age"
    type: yesno
    sql: ${age} < 45 ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: is_new_user {
    type: yesno
    sql: DATEDIFF(day,${created_date},CURRENT_DATE) < 7 ;;
  }

  measure: count_new_users {
    type: count
    filters: {
      field: is_new_user
      value: "yes"
    }
  }

  dimension: created_at_month {
    type: date_month
    sql: ${TABLE}.created_at ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: count_unique_ages {
    type: count_distinct
    sql: ${age} ;;
  }

  measure: count_users_under_45 {
    type: count
    filters: {
      field: is_below_45
      value: "yes"
    }
  }

  set: detail {
    fields: [id,state,city,country,created_date]
  }
}
