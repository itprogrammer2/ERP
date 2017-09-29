create table department (
  id int not null auto_increment PRIMARY KEY,
  description varchar(255) not null,
  is_active boolean default true,
  archived boolean default false
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

create table category (
  id int not null auto_increment PRIMARY KEY,
  description varchar(255) not null,
  is_active boolean default true,
  archived boolean default false
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

create table sub_category (
  id int not null auto_increment PRIMARY KEY,
  description varchar(255) not null,
  is_active boolean default true,
  archived boolean default false
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

create table measurement (
  id int not null auto_increment PRIMARY KEY,
  unit varchar(50) not null,
  abbreviation varchar(5) not null,
  description varchar(255) not null,
  is_active boolean default true,
  archived boolean default false
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

create table company (
  id int not null auto_increment PRIMARY KEY,
  name varchar(50) not null,
  product_key varchar(255) not null,
  tin_no varchar(255) not null,
  min_no varchar(255) not null,
  permit_no varchar(255) not null,
  accreditation_no varchar(255) not null,
  serial_no varchar(255) not null,
  vat varchar(255) not null,
  receipt_remarks_header varchar(500) not null,
  receipt_remarks_footer varchar(500) not null,
  is_active boolean default true,
  archived boolean default false
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

create table branch (
  id int not null auto_increment PRIMARY KEY,
  company_id int not null,
  trade_name varchar(100) not null,
  address text not null,
  is_active boolean default true,
  archived boolean default false,
  FOREIGN KEY(company_id) REFERENCES company(id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

create table job_title (
  id int not null auto_increment PRIMARY KEY,
  description varchar(50) not null,
  is_active boolean default true,
  archived boolean default false
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

create table modifications (
  id int not null auto_increment PRIMARY KEY,
  description varchar(100) not null,
  is_active boolean default true,
  archived boolean default false
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

create table user_level (
  id int not null auto_increment PRIMARY KEY,
  description varchar(50) not null,
  is_active boolean default true,
  archived boolean default false
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

create table users (
  id int not null auto_increment PRIMARY KEY,
  uid int not null UNIQUE,
  first_name varchar(255) not null,
  last_name varchar(255) not null,
  middle_name varchar(255) not null,
  job_title_id int not null,
  user_level_id int not null,
  address text not null,
  phone_number varchar(10),
  mobile_number varchar(10),
  email_address varchar(10),
  is_active boolean default true,
  branch text not null,
  FOREIGN KEY(job_title_id) REFERENCES job_title(id),
  FOREIGN KEY(user_level_id) REFERENCES user_level(id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

create table user_sessions (
	id int not null auto_increment PRIMARY KEY,
	users_id int not null REFERENCES user(id),
	auth_token text not null,
	expiration_date TIMESTAMP not null default CURRENT_TIMESTAMP,
	FOREIGN KEY(users_id) REFERENCES users(id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

create table charge_accounts (
  id int not null auto_increment PRIMARY KEY,
  first_name varchar(255) not null,
  last_name varchar(255) not null,
  middle_name varchar(255) not null,
  position_id int not null,
  address text not null,
  phone_number varchar(10),
  mobile_number varchar(10),
  email_address varchar(10),
  date_created TIMESTAMP default CURRENT_TIMESTAMP,
  created_by int not null,
  is_active boolean default false,
  archived boolean default false,
  FOREIGN KEY(created_by) REFERENCES users(id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

create table account (
  username int not null,
  password varchar(50) not null,
  FOREIGN KEY(username) REFERENCES users(uid)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

create table items (
  id varchar(20) not null UNIQUE PRIMARY KEY,
  barcode varchar(100) not null,
  abbreviation varchar(10) not null,
  description varchar(250) not null,
  department_id int not null,
  category_id int null,
  sub_category_id int null,
  measurement_id int not null,
  /* defined separately in document */
  cost numeric unsigned not null default 0.00,
  vat numeric unsigned not null ,
  markup numeric unsigned not null ,
  /* defined separately in document */
  non_vat boolean default false,
  alert_reordering boolean default false,
  min_stock_level numeric unsigned,
  max_stock_level numeric unsigned,
  open_price boolean default false,
  is_composed boolean default false,
  is_raw_material boolean default false,
  is_modified boolean default false,
  discount_exempt boolean default false,
  image varchar(255),
  is_active boolean default true,
  archived boolean default false,
  FOREIGN KEY(department_id) REFERENCES department(id),
  FOREIGN KEY(category_id) REFERENCES category(id),
  FOREIGN KEY(sub_category_id) REFERENCES sub_category(id),
  FOREIGN KEY(measurement_id) REFERENCES measurement(id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

create table item_modifications (
  id int not null auto_increment PRIMARY KEY,
  items_id varchar(20) not null,
  modifications_id int not null,
  is_active boolean default true,
  archived boolean default false,
  FOREIGN KEY(items_id) REFERENCES items(id),
  FOREIGN KEY(modifications_id) REFERENCES modifications(id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

create table reasons (
  id int not null auto_increment PRIMARY KEY,
  description varchar(100) not null,
  is_active boolean default true,
  archived boolean default false
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

create table raw_materials (
  id int not null auto_increment PRIMARY KEY,
  composed_items_id varchar(20) not null,
  items_id varchar(20) not null,
  archived boolean default false,
  FOREIGN KEY(composed_items_id) REFERENCES items(id),
  FOREIGN KEY(items_id) REFERENCES items(id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

create table change_price (
  id int not null auto_increment PRIMARY KEY,
  amount numeric not null,
  is_percent boolean default true,
  date_from TIMESTAMP default CURRENT_TIMESTAMP,
  date_to TIMESTAMP default CURRENT_TIMESTAMP,
  date_created TIMESTAMP default CURRENT_TIMESTAMP,
  created_by int not null,
  is_active boolean default false,
  archived boolean default false,
  FOREIGN KEY(created_by) REFERENCES users(id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

create table discount (
  id int not null auto_increment PRIMARY KEY,
  amount numeric not null,
  is_percent boolean default true,
  date_from TIMESTAMP default CURRENT_TIMESTAMP,
  date_to TIMESTAMP default CURRENT_TIMESTAMP,
  is_indefinite boolean default false,
  date_created TIMESTAMP default CURRENT_TIMESTAMP,
  created_by int not null,
  is_active boolean default true,
  archived boolean default false,
  FOREIGN KEY(created_by) REFERENCES users(id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

create table bank (
  id int not null auto_increment PRIMARY KEY,
  description varchar(100) not null,
  is_active boolean default true,
  archived boolean default false
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

create table currency (
  id int not null auto_increment PRIMARY KEY,
  description varchar(100) not null,
  is_active boolean default true,
  archived boolean default false
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

create table deposit_type (
  id int not null auto_increment PRIMARY KEY,
  description varchar(100) not null,
  is_active boolean default true,
  archived boolean default false
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

create table suppliers (
  id int not null auto_increment PRIMARY KEY,
  description varchar(100) not null,
  address text not null,
  contact_number varchar(50) not null,
  email varchar(50) not null,
  contact_person varchar(100) not null,
  is_active boolean default true,
  archived boolean default false
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

/*
AUDIT TRAIL
*/

create table department_history (
  department_id int not null auto_increment PRIMARY KEY,
  message text,
  date_created TIMESTAMP default CURRENT_TIMESTAMP,
  created_by int not null,
  FOREIGN KEY(created_by) REFERENCES users(id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;
