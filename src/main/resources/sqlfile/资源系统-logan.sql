create table access_record
(
    id            bigint unsigned auto_increment
        primary key,
    mobile        varchar(20)                                null comment '手机号',
    device_code   varchar(50)                                null comment '设备编号',
    sign_date     date                                       null comment '通行日期',
    sign_time     datetime                                   null comment '通行时间',
    status_handle tinyint unsigned default 0                 null comment '处理状态(0-待处理，1-已处理)',
    create_time   datetime         default CURRENT_TIMESTAMP null comment '记录创建时间',
    update_time   datetime         default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP comment '记录更新时间'
)
    comment '门禁通行记录表';

create index idx_mobile_sign_date
    on access_record (mobile, sign_date);

create index idx_sign_date
    on access_record (sign_date);

create index idx_sign_time
    on access_record (sign_time);

create table bd_corp
(
    BEGINDATE       char(10)       null,
    BRIEFINTRO      text           null,
    BUSIBEGINDATE   char(10)       null,
    BUSIENDDATE     char(10)       null,
    CHARGEDEPTCODE  varchar(60)    null,
    CHARGEDEPTNAME  varchar(60)    null,
    CITYCOUNTY      varchar(100)   null,
    CORPTYPE        char(20)       null,
    COUNTRYAREA     varchar(100)   null,
    CREATEDATE      char(10)       null,
    DEF1            varchar(100)   null,
    DEF10           varchar(100)   null,
    DEF11           varchar(100)   null,
    DEF12           varchar(100)   null,
    DEF13           varchar(100)   null,
    DEF14           varchar(100)   null,
    DEF15           varchar(100)   null,
    DEF16           varchar(100)   null,
    DEF17           varchar(100)   null,
    DEF18           varchar(100)   null,
    DEF19           varchar(100)   null,
    DEF2            varchar(100)   null,
    DEF20           varchar(100)   null,
    DEF3            varchar(100)   null,
    DEF4            varchar(100)   null,
    DEF5            varchar(100)   null,
    DEF6            varchar(100)   null,
    DEF7            varchar(100)   null,
    DEF8            varchar(100)   null,
    DEF9            varchar(100)   null,
    DR              decimal        null,
    ECOTYPE         char(20)       null,
    EMAIL1          varchar(50)    null,
    EMAIL2          varchar(50)    null,
    EMAIL3          varchar(50)    null,
    ENDDATE         varchar(50)    null,
    FATHERCORP      varchar(50)    null,
    FAX1            varchar(30)    null,
    FAX2            varchar(30)    null,
    FOREIGNNAME     varchar(60)    null,
    HOLDFLAG        char           null,
    IDNUMBER        varchar(60)    null,
    INDUSTRY        varchar(20)    null,
    INNERCODE       varchar(60)    null,
    ISHASACCOUNT    char           null,
    ISSEAL          char           null,
    ISUSERETAIL     char           not null,
    ISWORKINGUNIT   char           null,
    LEGALBODYCODE   varchar(25)    null,
    LINKMAN1        varchar(25)    null,
    LINKMAN2        varchar(25)    null,
    LINKMAN3        varchar(25)    null,
    MAXINNERCODE    varchar(60)    null,
    MEMO            varchar(100)   null,
    OWNERSHARERATE  decimal(9, 6)  null,
    PHONE1          varchar(30)    null,
    PHONE2          varchar(30)    null,
    PHONE3          varchar(30)    null,
    PK_CORP         varchar(50)    not null
        primary key,
    PK_CORPKIND     char(20)       null,
    PK_CURRENCY     char(20)       null,
    POSTADDR        text           null,
    PROVINCE        varchar(50)    null,
    REGCAPITAL      decimal(20, 2) null,
    REGION          char(20)       null,
    SALEADDR        text           null,
    SEALEDDATE      char(10)       null,
    SHOWORDER       decimal(38)    null,
    TAXCODE         varchar(20)    null,
    TAXPAYERTYPE    decimal(38)    null,
    TS              char(19)       null,
    UNITCODE        varchar(40)    not null,
    UNITDISTINCTION char(20)       null,
    UNITNAME        varchar(200)   not null,
    UNITSHORTNAME   varchar(40)    not null,
    URL             varchar(60)    null,
    ZIPCODE         char(6)        null,
    constraint I_BD_CORP_1
        unique (UNITCODE),
    constraint I_BD_CORP_2
        unique (UNITNAME)
);

create table bd_defdoclist
(
    DOCISLEVFLAG   char         not null,
    DOCLISTCODE    varchar(40)  not null,
    DOCLISTNAME    varchar(200) not null,
    DOCLISTSYSTYPE int          not null,
    DR             int          null,
    ISCORPCANCHG   char         null,
    PK_DEFDOCLIST  char(20)     not null
        primary key,
    TS             char(19)     null,
    constraint I_BD_DEFDOCLIST_1
        unique (DOCLISTCODE)
);

create table bd_defdoc
(
    DOCCODE       varchar(50)  not null,
    DOCNAME       varchar(200) not null,
    DOCSYSTYPE    int          not null,
    DR            int          null,
    MEMO          varchar(200) null,
    PK_CORP       char(4)      null,
    PK_DEFDOC     char(20)     not null
        primary key,
    PK_DEFDOC1    char(20)     null,
    PK_DEFDOCLIST char(20)     not null,
    SEALFLAG      char         null,
    SHORTNAME     varchar(200) null,
    TS            char(19)     null,
    constraint I_BD_DEFDOC_1
        unique (DOCCODE, PK_DEFDOCLIST, PK_CORP),
    constraint bd_defdoc_ibfk_1
        foreign key (PK_DEFDOCLIST) references bd_defdoclist (PK_DEFDOCLIST)
);

create index I_BD_DEFDOC_2
    on bd_defdoc (PK_DEFDOCLIST);

create table biz_article_collection
(
    id         varchar(32) not null
        primary key,
    shareId    varchar(32) null,
    userId     varchar(32) null,
    createTime datetime    null on update CURRENT_TIMESTAMP comment '收藏时间'
)
    comment '文章收藏表';

create table biz_article_share
(
    id          varchar(32)   not null comment '文章Id'
        primary key,
    deptId      varchar(32)   not null comment '发布单位',
    typeId      varchar(32)   not null comment '所属分类',
    title       varchar(255)  null comment '标题',
    mainPic     varchar(255)  null comment '主图',
    contentUrl  varchar(1000) null comment '内容url',
    publishTime datetime      null on update CURRENT_TIMESTAMP comment '发布时间',
    publisher   varchar(255)  null comment '发布人',
    readCount   int           null comment '阅读数量',
    pointCount  int           null comment '点赞数量'
)
    comment '文章表';

create table biz_article_type
(
    id         varchar(32)              not null comment '类型ID'
        primary key,
    parentId   varchar(32) default '-1' null comment '上级分类',
    deptId     varchar(32)              not null comment '部门ID',
    name       varchar(255)             null comment '分类名称',
    child      int         default 0    null comment '子分类数量',
    createTime datetime                 null comment '创建时间',
    creator    varchar(255)             null comment '创建人',
    updateTime datetime                 null comment '更新时间',
    updator    varchar(255)             null comment '更新人'
)
    comment '文章分类表';

create table biz_duty_location
(
    id         varchar(50) not null comment '主键'
        primary key,
    userId     varchar(50) null comment '用户ID',
    createTime datetime    null comment '创建时间',
    lng        double      null comment '经度',
    lat        double      null comment '纬度',
    radius     double      null comment '半径'
)
    comment '实时位置表';

create index lng
    on biz_duty_location (lng, lat);

create index userId
    on biz_duty_location (userId, createTime);

create definer = logan@`%` trigger update_day
    after insert
    on biz_duty_location
    for each row
BEGIN
    DECLARE mycount INT;
    IF (new.lng <> 5e-324 AND new.lat <> 5e-324) THEN
        SELECT COUNT(1)
        INTO mycount
        FROM biz_duty_location_day
        WHERE userId = new.userId AND date = DATE(new.createTime);
        IF (mycount > 0) THEN
            UPDATE biz_duty_location_day
            SET createTime = new.createTime,
                lng        = new.lng,
                lat        = new.lat,
                radius     = new.radius
            WHERE userId = new.userId
              AND date = DATE(new.createTime);
        ELSE
            INSERT INTO biz_duty_location_day(id, userId, date, createTime, lng, lat, radius)
            VALUES (new.id, new.userId, DATE(new.createTime), new.createTime, new.lng, new.lat, new.radius);
        END IF;
    END IF;
END;

create table biz_duty_location_day
(
    id         varchar(50) not null comment '主键'
        primary key,
    userId     varchar(50) null comment '用户ID',
    date       varchar(50) null comment '日期',
    createTime datetime    null comment '创建时间',
    lng        double      null comment '经度',
    lat        double      null comment '纬度',
    radius     double      null comment '半径'
)
    comment '每天实时最新位置表';

create index userId
    on biz_duty_location_day (userId, date);

create table biz_duty_rule
(
    id           varchar(32)   not null comment '主键ID'
        primary key,
    deptId       varchar(32)   not null comment '适用公司',
    name         varchar(255)  null comment '班次名称',
    days         varchar(255)  null comment '工作日设置：1-7 以逗号分隔',
    signTime     time          null comment '签到时间',
    signOutTime  time          null comment '签退时间',
    signOutTime2 varchar(50)   null comment '签退时间跨天',
    offsetRange  int           null comment '偏差范围',
    lng          double        null comment '考勤地点：经度',
    lat          double        null comment '考勤地点：纬度',
    signSite     varchar(255)  null comment '考勤地点',
    isFree       int default 0 null comment '是否自由卡规则：1-是、0-否',
    locations    text          null comment '其他考勤位置',
    createTime   datetime      null comment '创建时间',
    creator      varchar(255)  null comment '创建人',
    updateTime   datetime      null comment '更新时间',
    updator      varchar(255)  null comment '更新人'
)
    comment '考勤规则表';

create table biz_duty_schedule
(
    id         varchar(32)  not null comment '主键ID'
        primary key,
    userId     varchar(32)  not null comment '用户ID',
    ruleId     varchar(255) null comment '规则ID',
    day        date         null comment '排班日期',
    state      int          null comment '状态：0-启用 1-取消',
    createTime datetime     not null comment '创建时间',
    creator    varchar(255) null comment '创建人',
    updateTime datetime     null comment '更新时间',
    updator    varchar(255) null comment '更新人'
)
    comment '排班表';

create index day
    on biz_duty_schedule (day);

create index ruleId
    on biz_duty_schedule (ruleId);

create index state
    on biz_duty_schedule (state);

create index userId
    on biz_duty_schedule (userId);

create table biz_duty_sign
(
    id              varchar(32)                not null comment '主键ID'
        primary key,
    userId          varchar(32)                null comment '用户ID',
    ruleId          varchar(32)                null comment '班次ID',
    type            int(255)                   null comment '打卡类型：0-上班打卡，1-下班打卡，2-外出打卡',
    cardDate        date                       null comment '打卡日期',
    signDate        datetime                   null comment '打卡时间',
    date            datetime                   null comment '实际打卡时间',
    lng             double                     null comment '打卡地点：纬度',
    lat             double                     null comment '打卡地点：经度',
    signSite        varchar(255)               null comment '签到地点',
    state           int                        null comment '状态：0-成功，1-迟到，2-早退',
    noteInfo        varchar(255)               null comment '备注',
    source          tinyint unsigned default 1 null comment '来源(1-APP，2-门禁)',
    status_sync_shr tinyint unsigned default 0 null comment '同步SHR系统状态（0-未同步，1-已同步）'
)
    comment '考勤信息表' engine = MyISAM;

create index id
    on biz_duty_sign (id, userId, type, date, state);

create index idxCardDate
    on biz_duty_sign (cardDate);

create index ruleId
    on biz_duty_sign (ruleId);

create index ruleId_2
    on biz_duty_sign (ruleId, userId, date, type, state);

create index state
    on biz_duty_sign (state);

create index type
    on biz_duty_sign (type);

create index userId
    on biz_duty_sign (userId, date);

create index userId_2
    on biz_duty_sign (userId, type, date, state, signSite);

create table biz_duty_sign_count
(
    id           varchar(32)   not null comment '主键ID'
        primary key,
    userId       varchar(32)   null comment '用户ID',
    ruleId       varchar(32)   null comment '班次ID',
    ruleName     varchar(255)  null comment '班次名称',
    day          date          null comment '打卡日期',
    signTime     time          null comment '签到时间',
    signOutTime  time          null comment '签退时间',
    cardDate     datetime      null comment '上班打卡时间',
    cardState    int           null comment '上班打卡状态',
    cardOutDate  datetime      null comment '下班打卡时间',
    cardOutState int           null comment '下班打卡状态',
    outsideTimes int default 0 null comment '外出打卡次数',
    outside      text          null comment '外出打卡时间',
    outsideSite  text          null comment '外出打卡地点',
    freeTimes    int default 0 null comment '自由打卡次数',
    freeCard     text          null comment '自由打卡时间',
    freeSite     text          null comment '自由打卡地点'
);

create index userId
    on biz_duty_sign_count (userId, ruleId, day);

create index userId_2
    on biz_duty_sign_count (userId);

create table biz_safety_line
(
    id         varchar(32)  not null comment '主键ID'
        primary key,
    deptId     varchar(32)  null,
    name       varchar(255) null comment '路线名称',
    isOrder    int          null comment '是否有序：0-无序、1-有序',
    time       int          null comment '时限（分钟）',
    signWay    varchar(255) null comment '签到方式',
    state      int          null comment '状态：0-有效、1-无效',
    noteInfo   varchar(255) null comment '备注',
    createTime datetime     null comment '创建时间',
    creator    varchar(255) null comment '创建人',
    updateTime datetime     null comment '更新时间',
    updator    varchar(255) null comment '更新人'
)
    comment '安防巡逻路线';

create table biz_safety_line_point
(
    id      varchar(32) not null comment '主键ID'
        primary key,
    lineId  varchar(32) null comment '路线ID',
    pointId varchar(32) null comment '巡逻点ID',
    sn      int         null comment '排序'
)
    comment '巡逻路线与巡逻点关联表';

create table biz_safety_plan
(
    id         varchar(32)  not null comment '主键ID'
        primary key,
    deptId     varchar(32)  null,
    name       varchar(255) null comment '计划名称',
    executorId varchar(32)  null comment '执行人ID',
    frequency  int          null comment '执行频次：1-日/2-周/3-月/4-季度',
    startTime  varchar(50)  null comment '单次开始时间',
    endTime    varchar(50)  null comment '单次结束时间',
    createTime datetime     null comment '创建时间',
    creator    varchar(255) null comment '创建人',
    updateTime datetime     null comment '更新时间',
    updator    varchar(255) null comment '更新人'
)
    comment '安防巡逻计划表';

create table biz_safety_plan_line
(
    id     varchar(32) not null comment '主键ID'
        primary key,
    planId varchar(32) null comment '计划ID',
    lineId varchar(32) null
)
    comment '巡逻计划与路线关联表';

create table biz_safety_plan_log
(
    id            varchar(32)  not null comment '主键ID'
        primary key,
    planId        varchar(32)  null comment '计划ID',
    executorId    varchar(255) null comment '执行人ID',
    planStartTime datetime     null comment '计划开始时间',
    planEndTime   datetime     null comment '计划结束时间',
    realStartTime datetime     null comment '实际开始时间',
    realEndTime   datetime     null comment '实际结束时间',
    state         int          null comment '状态：0-待处理、1-已完成',
    noteInfo      varchar(255) null comment '备注'
)
    comment '计划执行情况';

create table biz_safety_plan_log_point
(
    id       varchar(32)  not null comment '主键ID'
        primary key,
    logId    varchar(32)  null comment '记录ID',
    planId   varchar(32)  null comment '计划ID',
    lineId   varchar(32)  null comment '路线ID',
    itemId   varchar(32)  null comment '检查项ID',
    state    int          null comment '状态：1-正常、0-异常',
    noteInfo varchar(255) null comment '备注'
)
    comment '记录关联表';

create table biz_safety_point
(
    id         varchar(32)  not null comment '主键ID'
        primary key,
    deptId     varchar(32)  null comment '项目ID',
    code       varchar(255) null comment '点位编号',
    name       varchar(255) null comment '点位名称',
    location   varchar(255) null comment '位置',
    lng        double       null comment '经度',
    lat        double       null comment '纬度',
    createTime datetime     null comment '创建时间',
    creator    varchar(255) null comment '创建人',
    updateTime datetime     null comment '更新时间',
    updator    varchar(255) null comment '更新人'
)
    comment '安防巡逻点';

create table biz_safety_point_item
(
    id       varchar(32)  not null comment '主键ID'
        primary key,
    pointId  varchar(32)  null comment '巡逻点ID',
    item     varchar(255) null comment '检查项',
    noteInfo varchar(255) null comment '备注'
)
    comment '安防巡逻点检查项';

create table cgform_button
(
    ID            varchar(32)  not null
        primary key,
    BUTTON_CODE   varchar(50)  null,
    button_icon   varchar(20)  null,
    BUTTON_NAME   varchar(50)  null,
    BUTTON_STATUS varchar(2)   null,
    BUTTON_STYLE  varchar(20)  null,
    EXP           varchar(255) null,
    FORM_ID       varchar(32)  null,
    OPT_TYPE      varchar(20)  null,
    order_num     int          null
);

create table cgform_button_sql
(
    ID           varchar(32) not null
        primary key,
    BUTTON_CODE  varchar(50) null,
    CGB_SQL      tinyblob    null,
    CGB_SQL_NAME varchar(50) null,
    CONTENT      longtext    null,
    FORM_ID      varchar(32) null
);

create table cgform_enhance_js
(
    ID         varchar(32) not null
        primary key,
    CG_JS      blob        null,
    CG_JS_TYPE varchar(20) null,
    CONTENT    longtext    null,
    FORM_ID    varchar(32) null
);

create table cgform_ftl
(
    ID           varchar(32)  not null
        primary key,
    CGFORM_ID    varchar(36)  not null,
    CGFORM_NAME  varchar(100) not null,
    CREATE_BY    varchar(36)  null,
    CREATE_DATE  datetime     null,
    CREATE_NAME  varchar(32)  null,
    FTL_CONTENT  longtext     null,
    FTL_STATUS   varchar(50)  null,
    FTL_VERSION  int          not null,
    FTL_WORD_URL varchar(200) null,
    UPDATE_BY    varchar(36)  null,
    UPDATE_DATE  datetime     null,
    UPDATE_NAME  varchar(32)  null
);

create table cgform_head
(
    id                varchar(32)  not null
        primary key,
    content           varchar(200) not null,
    create_by         varchar(32)  null,
    create_date       datetime     null,
    create_name       varchar(32)  null,
    is_checkbox       varchar(5)   not null,
    is_dbsynch        varchar(20)  not null,
    is_pagination     varchar(5)   not null,
    is_tree           varchar(5)   not null,
    jform_type        int          not null,
    jform_version     varchar(10)  not null,
    querymode         varchar(10)  not null,
    relation_type     int          null,
    sub_table_str     longtext     null,
    table_name        varchar(20)  not null,
    update_by         varchar(32)  null,
    update_date       datetime     null,
    update_name       varchar(32)  null,
    jform_pk_sequence varchar(200) null,
    jform_pk_type     varchar(100) null,
    tab_order         int          null
);

create table cgform_field
(
    id               varchar(32)  not null
        primary key,
    content          varchar(200) not null,
    create_by        varchar(255) null,
    create_date      datetime     null,
    create_name      varchar(32)  null,
    dict_field       varchar(100) null,
    dict_table       varchar(100) null,
    dict_text        varchar(100) null,
    field_default    varchar(20)  null,
    field_href       varchar(200) null,
    field_length     int          null,
    field_name       varchar(32)  not null,
    field_valid_type varchar(10)  null,
    is_key           varchar(2)   null,
    is_null          varchar(5)   null,
    is_query         varchar(5)   null,
    is_show          varchar(5)   null,
    is_show_list     varchar(5)   null,
    length           int          not null,
    main_field       varchar(100) null,
    main_table       varchar(100) null,
    old_field_name   varchar(32)  null,
    order_num        int          null,
    point_length     int          null,
    query_mode       varchar(10)  null,
    show_type        varchar(10)  null,
    type             varchar(32)  not null,
    update_by        varchar(32)  null,
    update_date      datetime     null,
    update_name      varchar(32)  null,
    table_id         varchar(32)  not null,
    constraint FK_iwtkke1oigq9ukafldrovslx6
        foreign key (table_id) references cgform_head (id)
);

create table ck_editor
(
    ID       varchar(32) not null
        primary key,
    CONTENTS blob        null
);

create table ck_finder
(
    ID         varchar(32)  not null
        primary key,
    ATTACHMENT varchar(255) null,
    IMAGE      varchar(255) null,
    REMARK     longtext     null
);

create table csh_about
(
    PKAID         varchar(50)  not null comment '相关方ID'
        primary key,
    PKCORP        varchar(50)  null comment '项目关联ID',
    CORRELATION   varchar(50)  null comment '相关方',
    NAME          varchar(100) null comment '相关方全称',
    ADDRESS       varchar(100) null comment '地址',
    PHONE         varchar(50)  null comment '电话',
    CHARGEPERSON  varchar(20)  null comment '负责人',
    CONTACTPERSON varchar(20)  null comment '联系人',
    REMARK        varchar(250) null comment '备注',
    RESERVE       varchar(100) null comment '备用',
    ADDTIME       varchar(30)  null comment '添加时间',
    PKAREA        varchar(50)  null comment '小区主键',
    TS            varchar(25)  null comment '时间戳'
)
    comment '相关方基本信息';

create table csh_bankinfo
(
    PK_BANKINFO      varchar(32)  not null
        primary key,
    PK_HOUSE         varchar(32)  null,
    VBANKCUSTNAME    varchar(50)  null,
    VBANKNAME        varchar(200) null,
    VBANKNO          varchar(50)  null,
    VBANKMEMO        varchar(200) null,
    PK_BANK_CORP     char(20)     null,
    VBANKBILLSTATUS  int          null,
    DBANKBILLDATE    char(10)     null,
    PK_BANK_BILLTYPE varchar(50)  null,
    PK_BANK_BUSITYPE varchar(50)  null,
    TS               char(19)     null,
    DR               int          null,
    VBANKDEF1        varchar(50)  null,
    VBANKDEF2        varchar(50)  null,
    VBANKDEF3        varchar(50)  null,
    VBANKDEF4        varchar(50)  null,
    VBANKDEF5        varchar(50)  null,
    VBANKDEF6        varchar(50)  null,
    VBANKDEF7        varchar(50)  null,
    VBANKDEF8        varchar(50)  null
);

create index CSH_BANKINFO_PK_HOUSE
    on csh_bankinfo (PK_HOUSE);

create table csh_carinfo
(
    PK_CARINFO      varchar(32)   not null
        primary key,
    PK_HOUSE        varchar(32)   null,
    VCARCUSTNAME    varchar(50)   null,
    VCARNO          varchar(50)   null,
    VCARBRAND       varchar(50)   null,
    VCARCOLOR       varchar(100)  null,
    DCARBUYDATE     char(10)      null,
    VCARPHONE       varchar(50)   null,
    VCARMEMO        varchar(200)  null,
    PK_CAR_CORP     char(20)      null,
    VCARBILLSTATUS  int           null,
    DCARBILLDATE    char(10)      null,
    PK_CAR_BILLTYPE varchar(50)   null,
    PK_CAR_BUSITYPE varchar(50)   null,
    TS              char(19)      null,
    DR              int default 0 null,
    VCARDEF1        varchar(50)   null comment '车位号',
    VCARDEF2        varchar(50)   null comment '备注',
    VCARDEF3        varchar(50)   null,
    VCARDEF4        varchar(50)   null,
    VCARDEF5        varchar(50)   null,
    VCARDEF6        varchar(50)   null,
    VCARDEF7        varchar(50)   null,
    VCARDEF8        varchar(50)   null
);

create index csh_carinfo_carphone
    on csh_carinfo (VCARPHONE);

create index csh_carinfo_pk_corp
    on csh_carinfo (PK_CAR_CORP);

create index csh_carinfo_pk_house
    on csh_carinfo (PK_HOUSE);

create table csh_city
(
    ID         varchar(32) not null comment '字典ID'
        primary key,
    DPID       varchar(32) null comment '上级字典ID，0表示根节点',
    DSORT      int         null comment '字典序号',
    DCODE      varchar(50) null comment '字典编码',
    DSNAME     varchar(50) null comment '字典名称',
    DLNAME     varchar(50) null comment '字典类别',
    DLVL       int         null comment '字典级别，root：0',
    LEAF       int         null comment '是否为叶子节点（是：1，否：0）',
    UPDATETIME datetime    null comment '时间戳',
    ISDELETED  varchar(10) null comment '删除标示（0：不删除，1：删除）'
)
    comment '事件类别信息表';

create table csh_equipment
(
    VBILLCODE          varchar(50)    null,
    VBILLSTATUS        int            null,
    BILLTYPE           char(20)       null,
    PK_BUSITYPE        char(20)       null,
    PK_CORP            varchar(50)    null,
    DR                 int default 0  null,
    TS                 char(19)       null,
    PK_EQUIPMENT       varchar(32)    not null
        primary key,
    PK_EQUIPMENTCLASS  char(20)       null,
    PK_SMALLAREA       varchar(32)    null,
    PK_MAP             varchar(32)    null,
    MAPLOCATION        varchar(100)   null,
    ORDERID            varchar(20)    null,
    EQUIPMENTNAME      varchar(100)   null,
    PK_EQUIPMENTTYPE   char(20)       null,
    EQUIPMENTCODE      varchar(50)    null,
    EQUIPMENTBRAND     varchar(50)    null,
    EQUIPMENTMODEL     varchar(50)    null,
    USERSTARTDATE      char(10)       null,
    USEENDDATE         char(10)       null,
    EQUIPMENTSTATUS    varchar(20)    null,
    PRICE              decimal(20, 8) null,
    MADER              varchar(100)   null,
    INSTATIONSITE      varchar(100)   null,
    SERVICEAREA        varchar(100)   null,
    REMAN              varchar(20)    null,
    REPAIRECOMPANY     varchar(50)    null,
    STARTTIME          varchar(20)    null,
    ENDDATETIME        varchar(20)    null,
    REPAIRESTART       char(10)       null,
    REPAIREEND         char(10)       null,
    DEPRECIATIONPERIOD decimal(20, 8) null,
    KEYEQUIPMENT       varchar(20)    null,
    SEPC               text           null,
    FISTPWD            varchar(20)    null,
    SECPWD             varchar(20)    null,
    THREEPWD           varchar(20)    null,
    SOFTBACKUP         varchar(100)   null,
    VMEMO              text           null,
    SORTNO             int            null,
    SECLEVE            int            null,
    PK_OPERATOR        varchar(50)    null,
    DMAKEDATE          char(10)       null,
    DMAKETIME          char(19)       null,
    VAPPROVEID         char(20)       null,
    VAPPROVEDATE       char(10)       null,
    LOCKDATE           char(10)       null,
    ISLOCK             char           null,
    LOCKMAN            varchar(20)    null,
    VDEF1              varchar(100)   null comment '安装日期',
    VDEF2              varchar(100)   null comment '年检日期',
    VDEF3              varchar(100)   null comment '有效期制',
    VDEF4              varchar(100)   null comment '造商国别',
    VDEF5              varchar(100)   null comment '设备重量',
    VDEF6              varchar(100)   null comment '设备净值（元）',
    VDEF7              varchar(100)   null comment '代理商通讯地址',
    VDEF8              varchar(100)   null comment '维修点通讯地址',
    VDEF9              varchar(100)   null comment '设备数量',
    VDEF10             text           null comment '辅助设备',
    PK_HISTORY         char(20)       null,
    RESOURCESCODE      varchar(100)   null,
    RESOURCESTYPE      varchar(20)    null,
    ISTWO              char           null,
    FREQUENCY          varchar(100)   null comment '巡检频次：日、周、月、季、年',
    STATE              int            null comment '状态：0-未处理、1-已处理'
);

create table csh_familyinfo
(
    PK_FAMILYINFO   varchar(50)   not null
        primary key,
    PK_HOUSE        varchar(32)   null,
    VNAME           varchar(50)   null,
    IAGE            int           null,
    CONCATWITHOWNER varchar(50)   null,
    COMPANY         varchar(100)  null,
    PHONE           varchar(50)   null,
    VMEMO           varchar(200)  null,
    PK_CORP         char(20)      null,
    VBILLSTATUS     int           null,
    DBILLDATE       char(10)      null,
    PK_BILLTYPE     varchar(50)   null,
    PK_BUSITYPE     varchar(50)   null,
    TS              char(19)      null,
    DR              int default 0 null,
    VDEF1           varchar(50)   null,
    VDEF2           varchar(50)   null,
    VDEF3           varchar(50)   null,
    VDEF4           varchar(50)   null,
    VDEF5           varchar(50)   null,
    VDEF6           varchar(50)   null,
    VDEF7           varchar(50)   null,
    VDEF8           varchar(50)   null,
    OWNERUID        varchar(100)  null,
    CSTGUID         varchar(50)   null
);

create index csh_familyinfo_cstguid
    on csh_familyinfo (CSTGUID);

create index csh_familyinfo_phone
    on csh_familyinfo (PHONE);

create index csh_familyinfo_pk_house
    on csh_familyinfo (PK_HOUSE);

create index csh_familyinfo_ts
    on csh_familyinfo (TS);

create table csh_fileattachment
(
    ID           varchar(32) not null comment '主键',
    RELATEDTABLE varchar(50) null comment '关联表名',
    RELATEDID    varchar(32) null comment '关联主键ID',
    RELATEDTYPE  varchar(50) null comment '关联类别根据不同表的数据自定义类别编码（例如事件表中1：事前图片，2：事后图片）',
    FILEPATH     text        null comment '文件路径',
    FILETYPE     varchar(50) null comment '文件类型',
    FILESIZE     int         null comment '文件大小',
    SORTORDER    int         null comment '排序（多个图片排序用）',
    INSERTTIME   datetime    null comment '录入时间',
    UPDATETIME   datetime    null comment '时间戳',
    ISDELETED    varchar(10) null comment '删除标志（0：不删除，1：删除）',
    constraint wywx_file_attachment_id
        unique (ID)
)
    comment '上传附件信息表';

create index wywx_file_attachment_relatedid
    on csh_fileattachment (RELATEDID);

create index wywx_file_attachment_relatedtable
    on csh_fileattachment (RELATEDTABLE);

create index wywx_file_attachment_relatedtype
    on csh_fileattachment (RELATEDTYPE);

alter table csh_fileattachment
    add primary key (ID);

create table csh_historyhouseinfo
(
    PK_HISTORYHOUSEINFO varchar(32)  not null
        primary key,
    PK_HOUSE            varchar(32)  null,
    VHISTORYNAME        varchar(50)  null,
    VHISTORYSEX         int          null,
    VHISTORYPHONE       varchar(50)  null,
    VHISTORYMEMO        varchar(200) null,
    PK_HISTORYCORP      char(20)     null,
    VHISTORYBILLSTATUS  int          null,
    DHISTORYBILLDATE    char(10)     null,
    PK_HISTORY_BILLTYPE varchar(50)  null,
    PK_HISTORY_BUSITYPE varchar(50)  null,
    TS                  char(19)     null,
    DR                  int          null,
    VHISTORYDEF1        varchar(50)  null,
    VHISTORYDEF2        varchar(50)  null,
    VHISTORYDEF3        varchar(50)  null,
    VHISTORYDEF4        varchar(50)  null,
    VHISTORYDEF5        varchar(50)  null,
    VHISTORYDEF6        varchar(50)  null,
    VHISTORYDEF7        varchar(50)  null,
    VHISTORYDEF8        varchar(50)  null
);

create table csh_house
(
    VBILLCODE     varchar(50)    null,
    VBILLSTATUS   int            null,
    BILLTYPE      char(4)        null,
    BILLTY        char(20)       null,
    PK_CORP       varchar(50)    null,
    DR            int            null,
    TS            char(19)       null,
    PK_HOUSE      varchar(50)    not null
        primary key,
    PK_HOUSETYPE  varchar(50)    null,
    FLOOR         varchar(20)    null,
    ROOMNO        varchar(20)    null,
    HOUSENO       varchar(20)    null,
    USEAGE        varchar(50)    null,
    USESTATA      varchar(100)   null,
    MADEAREANUM   decimal(20, 8) null,
    FACTAREANUM   decimal(20, 8) null,
    ACCOUNTBANK   varchar(50)    null,
    ACCOUNT       varchar(20)    null,
    ISUSE         char           null,
    HOUSECARDNO   varchar(50)    null,
    CONTRACTNO    varchar(50)    null,
    PK_OWNER      varchar(200)   null,
    VMEMO         text           null,
    SORTNO        int            null,
    SECLEVE       int            null,
    PK_OPERATOR   varchar(50)    null,
    DMAKEDATE     char(10)       null,
    DMAKETIME     char(19)       null,
    VAPPROVEID    char(20)       null,
    DAPPROVEDATE  char(10)       null,
    VAPPROVENOTE  text           null,
    LOCKDATE      char(10)       null,
    ISLOCK        char           null,
    LOCKMAN       varchar(20)    null,
    VDEF1         varchar(100)   null,
    VDEF2         varchar(100)   null,
    VDEF3         varchar(100)   null,
    VDEF4         varchar(100)   null,
    VDEF5         varchar(100)   null,
    VDEF6         varchar(100)   null,
    VDEF7         varchar(100)   null,
    VDEF8         varchar(100)   null,
    VDEF9         varchar(100)   null,
    VDEF10        varchar(100)   null,
    SBILLCODE     varchar(50)    null,
    PK_HISTORY    char(20)       null,
    ISRENT        char           null,
    STATE         varchar(50)    null,
    CANRENT       char           null,
    VOWNERNAME    varchar(200)   null,
    RESOURCESCODE varchar(100)   null,
    RESOURCESTYPE varchar(20)    null,
    ROOMTYPE      varchar(20)    null,
    ROOMNUM       decimal(20, 8) null,
    HALLNUM       decimal(20, 8) null,
    KITCHENNUM    decimal(20, 8) null,
    TOILETNUM     decimal(20, 8) null,
    PK_MAP        char(20)       null,
    MAPLOCATION   varchar(50)    null,
    ISLEASED      char           null,
    MONEYAREANUM  decimal(20, 8) null comment '收费面积',
    GLFDJ         decimal(20, 8) null comment '管理费单价',
    SFFZ          char           null,
    XHFG          varchar(20)    null,
    KD            varchar(20)    null,
    CONSTAREA     decimal(20, 8) null comment '建筑面积',
    INAREA        decimal(20, 8) null comment '实用面积(m²)',
    SALEAREA      decimal(20, 8) null comment '销售面积',
    WYAREA        decimal(20, 8) null comment '物业面积',
    PRICE         varchar(50)    null comment '价值',
    ROOMGUID      varchar(50)    null comment '明源中间库房产ID'
);

create index CSH_HOUSE_CORP
    on csh_house (PK_CORP);

create index CSH_HOUSE_DR
    on csh_house (DR);

create index CSH_HOUSE_PK_HOUSETYPE
    on csh_house (PK_HOUSETYPE);

create index CSH_HOUSE_PK_OWNER
    on csh_house (PK_OWNER);

create index CSH_HOUSE_RESOURCESTYPE
    on csh_house (RESOURCESTYPE);

create index CSH_HOUSE_ROOMGUID
    on csh_house (ROOMGUID);

create index CSH_HOUSE_RTYPE
    on csh_house (RESOURCESTYPE);

create index CSH_HOUSE_TS
    on csh_house (TS);

create table csh_house_bk_03_06
(
    VBILLCODE     varchar(50)    null,
    VBILLSTATUS   int            null,
    BILLTYPE      char(4)        null,
    BILLTY        char(20)       null,
    PK_CORP       varchar(50)    null,
    DR            int            null,
    TS            char(19)       null,
    PK_HOUSE      varchar(50)    not null,
    PK_HOUSETYPE  varchar(50)    null,
    FLOOR         varchar(20)    null,
    ROOMNO        varchar(20)    null,
    HOUSENO       varchar(20)    null,
    USEAGE        varchar(50)    null,
    USESTATA      varchar(100)   null,
    MADEAREANUM   decimal(20, 8) null,
    FACTAREANUM   decimal(20, 8) null,
    ACCOUNTBANK   varchar(50)    null,
    ACCOUNT       varchar(20)    null,
    ISUSE         char           null,
    HOUSECARDNO   varchar(50)    null,
    CONTRACTNO    varchar(50)    null,
    PK_OWNER      varchar(200)   null,
    VMEMO         text           null,
    SORTNO        int            null,
    SECLEVE       int            null,
    PK_OPERATOR   varchar(50)    null,
    DMAKEDATE     char(10)       null,
    DMAKETIME     char(19)       null,
    VAPPROVEID    char(20)       null,
    DAPPROVEDATE  char(10)       null,
    VAPPROVENOTE  text           null,
    LOCKDATE      char(10)       null,
    ISLOCK        char           null,
    LOCKMAN       varchar(20)    null,
    VDEF1         varchar(100)   null,
    VDEF2         varchar(100)   null,
    VDEF3         varchar(100)   null,
    VDEF4         varchar(100)   null,
    VDEF5         varchar(100)   null,
    VDEF6         varchar(100)   null,
    VDEF7         varchar(100)   null,
    VDEF8         varchar(100)   null,
    VDEF9         varchar(100)   null,
    VDEF10        varchar(100)   null,
    SBILLCODE     varchar(50)    null,
    PK_HISTORY    char(20)       null,
    ISRENT        char           null,
    STATE         varchar(50)    null,
    CANRENT       char           null,
    VOWNERNAME    varchar(200)   null,
    RESOURCESCODE varchar(100)   null,
    RESOURCESTYPE varchar(20)    null,
    ROOMTYPE      varchar(20)    null,
    ROOMNUM       decimal(20, 8) null,
    HALLNUM       decimal(20, 8) null,
    KITCHENNUM    decimal(20, 8) null,
    TOILETNUM     decimal(20, 8) null,
    PK_MAP        char(20)       null,
    MAPLOCATION   varchar(50)    null,
    ISLEASED      char           null,
    MONEYAREANUM  decimal(20, 8) null comment '收费面积',
    GLFDJ         decimal(20, 8) null comment '管理费单价',
    SFFZ          char           null,
    XHFG          varchar(20)    null,
    KD            varchar(20)    null,
    CONSTAREA     decimal(20, 8) null comment '建筑面积',
    INAREA        decimal(20, 8) null comment '实用面积(m²)',
    SALEAREA      decimal(20, 8) null comment '销售面积',
    WYAREA        decimal(20, 8) null comment '物业面积',
    PRICE         varchar(50)    null comment '价值',
    ROOMGUID      varchar(50)    null comment '明源中间库房产ID'
);

create table csh_housetype
(
    VBILLCODE      varchar(50)    null,
    VBILLSTATUS    int            null,
    PK_BUSITYPE    char(20)       null,
    BILLTYPE       char(4)        null,
    PK_CORP        varchar(50)    null,
    PK_SMALLAREA   varchar(50)    null,
    DR             int            null,
    TS             char(19)       null,
    PK_HOUSETYPE   varchar(50)    not null
        primary key,
    BUILDINGNAME   varchar(50)    null comment '楼宇名称',
    ZDYNUM         decimal(20, 8) null comment '总单元数',
    ZLCNUM         decimal(20, 8) null comment '总楼层数',
    KZHNUM         decimal(20, 8) null comment '空置户数',
    BILDINGMEASURE decimal(20, 8) null comment '楼栋面积',
    UNDERMEASURE   decimal(20, 8) null,
    QLMEASURE      decimal(20, 8) null,
    TLMEASURE      decimal(20, 8) null,
    ELEVATORNUM    decimal(20, 8) null comment '电梯数量',
    LDHS           decimal(20, 8) null comment '楼栋户数',
    ZZHS           decimal(20, 8) null comment '自住户数',
    CZHS           decimal(20, 8) null comment '出租户数',
    VMEMO          text           null comment '备注',
    SORTNO         int            null,
    SECLEVE        int            null,
    PK_OPERATOR    varchar(50)    null,
    DMAKEDATE      char(10)       null,
    DMAKETIME      char(19)       null,
    VAPPROVEID     char(20)       null,
    VAPPROVEDATE   char(10)       null,
    ISLOCK         char           null,
    LOCKMAN        varchar(20)    null,
    LOCKDATE       char(10)       null,
    VDEF1          varchar(100)   null,
    VDEF2          varchar(100)   null,
    VDEF3          varchar(100)   null,
    VDEF4          varchar(100)   null,
    VDEF5          varchar(100)   null,
    VDEF6          varchar(100)   null,
    VDEF7          varchar(100)   null,
    VDEF8          varchar(100)   null,
    VDEF9          varchar(100)   null,
    VDEF10         varchar(100)   null,
    PK_HISTORY     char(20)       null,
    USESTATA       text           null,
    CLUBNUM        decimal(20, 8) null,
    PLAYPONDNUM    decimal(20, 8) null,
    BUILDTYPE      varchar(20)    null comment '建筑类别',
    ISRENT         char           null,
    CANRENT        char           null,
    BUILDINGCODE   varchar(100)   null comment '楼宇编码',
    TOWERNUM       decimal(20, 8) null,
    SKIRTNUM       decimal(20, 8) null,
    DROOMNUM       decimal(20, 8) null comment '地下室层数',
    PK_MAP         char(20)       null,
    MAPLOCATION    varchar(100)   null,
    BLDGUID        varchar(50)    null comment '明源中间库楼宇主键ID',
    JOINDATE       varchar(19)    null comment '入伙时间',
    ISJOIN         varchar(10)    null comment '是否入伙(1：是，0：否)'
);

create index CSH_HOUSETYPE_BLDGUID
    on csh_housetype (BLDGUID);

create index CSH_HOUSETYPE_CORP
    on csh_housetype (PK_CORP);

create index CSH_HOUSETYPE_PK_HOUSETYPE
    on csh_housetype (PK_HOUSETYPE);

create definer = logan@`%` trigger updatebuildname
    after update
    on csh_housetype
    for each row
begin
    if new.buildingname != old.buildingname then
        update csh_house set vdef5=new.buildingname where pk_housetype = new.pk_housetype;
    end if;
end;

create table csh_housetype_bk_03_06
(
    VBILLCODE      varchar(50)    null,
    VBILLSTATUS    int            null,
    PK_BUSITYPE    char(20)       null,
    BILLTYPE       char(4)        null,
    PK_CORP        varchar(50)    null,
    PK_SMALLAREA   varchar(50)    null,
    DR             int            null,
    TS             char(19)       null,
    PK_HOUSETYPE   varchar(50)    not null,
    BUILDINGNAME   varchar(50)    null comment '楼宇名称',
    ZDYNUM         decimal(20, 8) null comment '总单元数',
    ZLCNUM         decimal(20, 8) null comment '总楼层数',
    KZHNUM         decimal(20, 8) null comment '空置户数',
    BILDINGMEASURE decimal(20, 8) null comment '楼栋面积',
    UNDERMEASURE   decimal(20, 8) null,
    QLMEASURE      decimal(20, 8) null,
    TLMEASURE      decimal(20, 8) null,
    ELEVATORNUM    decimal(20, 8) null comment '电梯数量',
    LDHS           decimal(20, 8) null comment '楼栋户数',
    ZZHS           decimal(20, 8) null comment '自住户数',
    CZHS           decimal(20, 8) null comment '出租户数',
    VMEMO          text           null comment '备注',
    SORTNO         int            null,
    SECLEVE        int            null,
    PK_OPERATOR    varchar(50)    null,
    DMAKEDATE      char(10)       null,
    DMAKETIME      char(19)       null,
    VAPPROVEID     char(20)       null,
    VAPPROVEDATE   char(10)       null,
    ISLOCK         char           null,
    LOCKMAN        varchar(20)    null,
    LOCKDATE       char(10)       null,
    VDEF1          varchar(100)   null,
    VDEF2          varchar(100)   null,
    VDEF3          varchar(100)   null,
    VDEF4          varchar(100)   null,
    VDEF5          varchar(100)   null,
    VDEF6          varchar(100)   null,
    VDEF7          varchar(100)   null,
    VDEF8          varchar(100)   null,
    VDEF9          varchar(100)   null,
    VDEF10         varchar(100)   null,
    PK_HISTORY     char(20)       null,
    USESTATA       text           null,
    CLUBNUM        decimal(20, 8) null,
    PLAYPONDNUM    decimal(20, 8) null,
    BUILDTYPE      varchar(20)    null comment '建筑类别',
    ISRENT         char           null,
    CANRENT        char           null,
    BUILDINGCODE   varchar(100)   null comment '楼宇编码',
    TOWERNUM       decimal(20, 8) null,
    SKIRTNUM       decimal(20, 8) null,
    DROOMNUM       decimal(20, 8) null comment '地下室层数',
    PK_MAP         char(20)       null,
    MAPLOCATION    varchar(100)   null,
    BLDGUID        varchar(50)    null comment '明源中间库楼宇主键ID'
);

create table csh_owner
(
    VBILLCODE       varchar(50)  null,
    VBILLSTATUS     int          null,
    BILLTYPE        char(4)      null,
    PK_BUSITYPE     char(20)     null,
    PK_CORP         varchar(50)  null,
    DR              int          null,
    TS              char(19)     null,
    PK_OWNER        varchar(50)  not null,
    ISOWNER         char         null,
    OWNERTYPE       varchar(20)  null,
    CONCATWITHOWNER varchar(20)  null,
    PK_FATHER       varchar(120) null,
    VNAME           varchar(100) null,
    PHOTO           text         null,
    GENDER          int          null,
    BORTHDATE       char(10)     null,
    MARRYSTATE      varchar(20)  null,
    MZ              varchar(20)  null,
    JG              varchar(50)  null,
    PERSONCARDTYPE  varchar(20)  null,
    PERSONCARDNO    varchar(50)  null,
    COMPANY         varchar(50)  null,
    TITLE           varchar(20)  null,
    HOUSENO         varchar(20)  null,
    ENTERDATE       char(10)     null,
    ISSUEDATE       char(10)     null,
    VGETDATE        char(10)     null,
    CONCATPERSON    varchar(100) null,
    PHONE           varchar(100) null,
    PHONE1          varchar(50)  null,
    PHONE2          varchar(50)  null,
    EMAIL           varchar(50)  null,
    CONCATADDRESS   varchar(200) null,
    CARDNO          varchar(20)  null,
    CJH             varchar(20)  null,
    ENGINENO        varchar(20)  null,
    BUYCARDDATE     char(10)     null,
    CARDTYPENO      varchar(20)  null,
    VMEMO           text         null,
    SORTNO          int          null,
    SECLEVE         int          null,
    PK_OPERATOR     varchar(50)  null,
    DMAKEDATE       char(10)     null,
    DMAKETIME       char(19)     null,
    VAPPROVEID      char(20)     null,
    VAPPROVEDATE    char(10)     null,
    LOCKDATE        char(10)     null,
    ISLOCK          char         null,
    LOCKMAN         varchar(20)  null,
    VDEF1           varchar(100) null,
    VDEF2           varchar(100) null,
    VDEF3           varchar(100) null,
    VDEF4           varchar(100) null,
    VDEF5           varchar(100) null,
    VDEF6           varchar(100) null,
    VDEF7           varchar(100) null,
    VDEF8           varchar(100) null,
    VDEF9           varchar(100) null,
    VDEF10          varchar(100) null,
    PK_HISTORY      char(20)     null,
    ACCOUNTBANK     varchar(50)  null,
    ACCOUNT         varchar(50)  null,
    ISUSE           char         null,
    RESOURCESTYPE   varchar(20)  null,
    RESOURCESCODE   varchar(100) null,
    SMOKE           char         null,
    WINE            char         null,
    FOOD            char         null,
    SPORT           char         null,
    OTHER           text         null,
    FAX             varchar(50)  null,
    ISVIP           varchar(2)   null comment '是否是vip',
    ISPROB          varchar(2)   null comment '是否为问题客户',
    WORKUNIT        varchar(100) null comment '工作单位',
    WORKSTATION     varchar(100) null comment '岗位',
    OWNERUID        varchar(100) null comment '业主唯一ID',
    CSTGUID         varchar(50)  null comment '明源中间库业主ID',
    PROVINCE        varchar(20)  null comment '省份',
    ZONE            varchar(20)  null comment '市区',
    CSNF            varchar(10)  null comment '出生年份',
    CSTSTATE        varchar(50)  null comment '明源系统对接
业主状态(非业主、正签、入伙)',
    JOINDATE        varchar(50)  null comment '明源系统对接入伙登记时间',
    CSTQSDATE       varchar(50)  null comment '业主合同签署日期',
    constraint CSH_OWNER_PK
        unique (PK_OWNER)
);

create index CSH_OWNER_CORP
    on csh_owner (PK_CORP);

create index CSH_OWNER_CSNF
    on csh_owner (CSNF);

create index CSH_OWNER_CSTGUID
    on csh_owner (CSTGUID);

create index CSH_OWNER_ISPROB
    on csh_owner (ISPROB);

create index CSH_OWNER_ISVIP
    on csh_owner (ISVIP);

create index CSH_OWNER_OWNERUID
    on csh_owner (OWNERUID);

create index CSH_OWNER_PERSONCARDNO
    on csh_owner (PERSONCARDNO);

create index CSH_OWNER_PHONE
    on csh_owner (PHONE);

create index CSH_OWNER_PHONE_VNAME
    on csh_owner (PHONE, VNAME);

create index CSH_OWNER_PK_HOUSE
    on csh_owner (VDEF5);

create index CSH_OWNER_PROVINCE
    on csh_owner (PROVINCE);

create index CSH_OWNER_VNAME_PHONE
    on csh_owner (VNAME, PHONE);

create index CSH_OWNER_ZONE
    on csh_owner (ZONE);

alter table csh_owner
    add primary key (PK_OWNER);

create table csh_owner_bk_03_06
(
    VBILLCODE       varchar(50)  null,
    VBILLSTATUS     int          null,
    BILLTYPE        char(4)      null,
    PK_BUSITYPE     char(20)     null,
    PK_CORP         varchar(50)  null,
    DR              int          null,
    TS              char(19)     null,
    PK_OWNER        varchar(50)  not null,
    ISOWNER         char         null,
    OWNERTYPE       varchar(20)  null,
    CONCATWITHOWNER varchar(20)  null,
    PK_FATHER       varchar(120) null,
    VNAME           varchar(100) null,
    PHOTO           text         null,
    GENDER          int          null,
    BORTHDATE       char(10)     null,
    MARRYSTATE      varchar(20)  null,
    MZ              varchar(20)  null,
    JG              varchar(50)  null,
    PERSONCARDTYPE  varchar(20)  null,
    PERSONCARDNO    varchar(50)  null,
    COMPANY         varchar(50)  null,
    TITLE           varchar(20)  null,
    HOUSENO         varchar(20)  null,
    ENTERDATE       char(10)     null,
    ISSUEDATE       char(10)     null,
    VGETDATE        char(10)     null,
    CONCATPERSON    varchar(100) null,
    PHONE           varchar(100) null,
    PHONE1          varchar(50)  null,
    PHONE2          varchar(50)  null,
    EMAIL           varchar(50)  null,
    CONCATADDRESS   varchar(200) null,
    CARDNO          varchar(20)  null,
    CJH             varchar(20)  null,
    ENGINENO        varchar(20)  null,
    BUYCARDDATE     char(10)     null,
    CARDTYPENO      varchar(20)  null,
    VMEMO           text         null,
    SORTNO          int          null,
    SECLEVE         int          null,
    PK_OPERATOR     varchar(50)  null,
    DMAKEDATE       char(10)     null,
    DMAKETIME       char(19)     null,
    VAPPROVEID      char(20)     null,
    VAPPROVEDATE    char(10)     null,
    LOCKDATE        char(10)     null,
    ISLOCK          char         null,
    LOCKMAN         varchar(20)  null,
    VDEF1           varchar(100) null,
    VDEF2           varchar(100) null,
    VDEF3           varchar(100) null,
    VDEF4           varchar(100) null,
    VDEF5           varchar(100) null,
    VDEF6           varchar(100) null,
    VDEF7           varchar(100) null,
    VDEF8           varchar(100) null,
    VDEF9           varchar(100) null,
    VDEF10          varchar(100) null,
    PK_HISTORY      char(20)     null,
    ACCOUNTBANK     varchar(50)  null,
    ACCOUNT         varchar(50)  null,
    ISUSE           char         null,
    RESOURCESTYPE   varchar(20)  null,
    RESOURCESCODE   varchar(100) null,
    SMOKE           char         null,
    WINE            char         null,
    FOOD            char         null,
    SPORT           char         null,
    OTHER           text         null,
    FAX             varchar(50)  null,
    ISVIP           varchar(2)   null comment '是否是vip',
    ISPROB          varchar(2)   null comment '是否为问题客户',
    WORKUNIT        varchar(100) null comment '工作单位',
    WORKSTATION     varchar(100) null comment '岗位',
    OWNERUID        varchar(100) null comment '业主唯一ID',
    CSTGUID         varchar(50)  null comment '明源中间库业主ID',
    PROVINCE        varchar(20)  null comment '省份',
    ZONE            varchar(20)  null comment '市区',
    CSNF            varchar(10)  null comment '出生年份',
    CSTSTATE        varchar(50)  null comment '明源系统对接
业主状态(非业主、正签、入伙)',
    JOINDATE        varchar(50)  null comment '明源系统对接入伙登记时间'
);

create table csh_petinfo
(
    PK_PETINFO varchar(32)  not null
        primary key,
    PK_HOUSE   varchar(32)  null,
    PETTYPE    varchar(50)  null,
    PETNAME    varchar(50)  null,
    PETAGE     varchar(50)  null,
    PETCOLOR   varchar(50)  null,
    PETMEMO    varchar(200) null,
    PK_CORP    char(20)     null,
    TS         char(19)     null,
    DR         int          null
);

create index CSH_PETINFO_PK_HOUSE
    on csh_petinfo (PK_HOUSE);

create table csh_sbwbjh
(
    ID           varchar(32)  not null
        primary key,
    LBID         varchar(32)  null comment '维保类型ID',
    LBMC         varchar(50)  null comment '维保类型名称',
    JHRQ         varchar(50)  null comment '计划日期',
    WCRQ         varchar(50)  null comment '完成时间',
    QRRQ         varchar(50)  null comment '管家确认完成时间',
    ZRBM         varchar(200) null comment '责任部门',
    ZRRY         varchar(50)  null comment '责任人',
    ZRRYWXID     varchar(50)  null comment '责任人微信openid',
    BEIZ         text         null comment '备注',
    GDBH         varchar(50)  null comment '工单编号',
    FLAG         varchar(50)  null comment '状态标识（0：未完成，1：已派工，2：维保完成，3：确认完成）',
    LRRYID       varchar(50)  null comment '录入人员ID',
    LRRYMC       varchar(50)  null comment '录入人员姓名',
    LRRYWXID     varchar(50)  null comment '录入人微信openid（管家）',
    LRRYDEPTID   varchar(50)  null comment '录入人员部门',
    PK_CORP      varchar(50)  null comment '组织机构ID',
    PK_EQUIPMENT varchar(50)  null comment '设备ID',
    DR           varchar(255) null comment '删除标示',
    DMAKEDATE    varchar(19)  null comment '录入时间',
    TS           varchar(19)  null comment '时间戳'
)
    comment '设备维保计划信息表';

create table csh_sbwbjhlb
(
    ID         varchar(32)  not null comment '字典ID'
        primary key,
    DPID       varchar(32)  null comment '上级字典ID，0表示根节点',
    DSORT      int          null comment '字典序号',
    DCODE      varchar(50)  null comment '字典编码',
    DSNAME     varchar(50)  null comment '字典名称-简称short',
    DLNAME     varchar(120) null comment '字典名称-全称long',
    DLVL       int          null comment '字典级别，root：0',
    LEAF       int          null comment '是否为叶子节点（是：1，否：0）',
    UPDATETIME datetime     null comment '时间戳',
    ISDELETED  varchar(10)  null comment '删除标示（0：不删除，1：删除）'
)
    comment '维保类别信息表';

create table csh_sbxjjh
(
    ID           varchar(32)  not null
        primary key,
    LBID         varchar(32)  null comment '巡检类型ID',
    LBMC         varchar(50)  null comment '巡检类型名称',
    ZXRQ         varchar(50)  null comment '首次执行日期',
    ZXSJ         varchar(50)  null comment '执行时间',
    WCRQ         varchar(50)  null comment '完成时间',
    QRRQ         varchar(50)  null comment '管家确认完成时间',
    ZRBM         varchar(200) null comment '责任部门',
    ZRRY         varchar(50)  null comment '责任人',
    ZRRYWXID     varchar(50)  null comment '责任人微信openid',
    BEIZ         text         null comment '备注',
    FLAG         varchar(50)  null comment '状态标识（0：未完成，1：已派工，2：巡检完成）',
    LRRYID       varchar(50)  null comment '录入人员ID',
    LRRYMC       varchar(50)  null comment '录入人员姓名',
    LRRYWXID     varchar(50)  null comment '录入人微信openid（管家）',
    LRRYDEPTID   varchar(50)  null comment '录入人员部门',
    PK_CORP      varchar(50)  null comment '组织机构ID',
    PK_EQUIPMENT varchar(50)  null comment '设备ID',
    DR           varchar(255) null comment '删除标示',
    DMAKEDATE    varchar(19)  null comment '录入时间',
    TS           varchar(19)  null comment '时间戳'
)
    comment '设备巡检计划信息表';

create table csh_sbxjjl
(
    ID           varchar(32)  not null comment '主键ID'
        primary key,
    JHID         varchar(32)  null comment '巡检计划ID',
    LBID         varchar(32)  null comment '类别编码',
    LBMC         varchar(255) null comment '类别名称',
    ZXRQ         varchar(100) null comment '执行日期',
    ZXSJ         varchar(100) null comment '执行时间',
    XJRY         varchar(100) null comment '巡检人员',
    XJRYID       varchar(32)  null comment '巡检人员ID',
    ZRBM         varchar(255) null comment '巡检人员所属部门',
    XJJG         text         null comment '巡检结果',
    LRRYID       varchar(50)  null comment '录入人员ID',
    LRRYMC       varchar(50)  null comment '录入人员姓名',
    STATE        int          null comment '状态：0-未完成，1-已完成',
    TYPE         int          null comment '执行类型：0-频次，1-立即',
    INSERTTIME   datetime     null comment '录入时间',
    UPDATETIME   datetime     null comment '时间戳',
    PK_EQUIPMENT varchar(255) null comment '设备ID'
)
    comment '设备巡检记录信息表';

create table csh_shijian
(
    ID         varchar(32)  not null comment '事件主键ID'
        primary key,
    LBID       varchar(32)  null comment '事件类别编码',
    LBMC       varchar(50)  null comment '事件类别名称',
    SJSJ       datetime     null comment '事件时间',
    SJDD       varchar(200) null comment '事件地点',
    SJMS       text         null comment '事件描述',
    CLJG       text         null comment '事件处理结果',
    CLRY       varchar(50)  null comment '事件处理人员',
    SJPJ       text         null comment '事件评价内容',
    ZYLB       varchar(50)  null comment '资源类别编码（1：项目，2：建筑物，3：房产，4：设备）',
    ZYID       varchar(100) null comment '资源主键ID',
    YXJZ       varchar(50)  null comment '是否影响资源价值',
    SQJZ       varchar(50)  null comment '事前价值',
    SHJZ       varchar(50)  null comment '事后价值',
    LRRYID     varchar(50)  null comment '录入人员ID',
    LRRYMC     varchar(50)  null comment '录入人员姓名',
    INSERTTIME datetime     null comment '录入时间',
    UPDATETIME datetime     null comment '时间戳',
    ISDELETED  varchar(10)  null comment '删除标志（0：不删除，1：删除）',
    PK_CORP    varchar(50)  null comment '组织机构ID',
    ZYMC       varchar(100) null comment '资源名称',
    ZYLBMC     varchar(50)  null comment '资源类别名称',
    JHID       varchar(50)  null comment '计划ID（设备维保计划）CSH_SBWBJH表ID'
)
    comment '事件信息表';

create table csh_shijianlb
(
    ID         varchar(32)  not null comment '字典ID'
        primary key,
    DPID       varchar(32)  null comment '上级字典ID，0表示根节点',
    DSORT      int          null comment '字典序号',
    DCODE      varchar(50)  null comment '字典编码',
    DSNAME     varchar(50)  null comment '字典名称-简称short',
    DLNAME     varchar(120) null comment '字典名称-全称long',
    DLVL       int          null comment '字典级别，root：0',
    LEAF       int          null comment '是否为叶子节点（是：1，否：0）',
    UPDATETIME datetime     null comment '时间戳',
    ISDELETED  varchar(10)  null comment '删除标示（0：不删除，1：删除）'
)
    comment '事件类别信息表';

create table csh_shipinjk
(
    ID          varchar(50)  not null comment '通道ID'
        primary key,
    DEVICEID    varchar(50)  null comment '设备ID',
    CHANNELNUM  varchar(50)  null comment '通道号',
    MAPLOCATION text         null comment '位置信息',
    CHANNELNAME varchar(100) null comment '通道名称',
    TS          char(19)     null comment '创建时间',
    PK_CORP     varchar(50)  null comment '组织机构ID'
);

create table csh_smallarea
(
    VBILLCODE       varchar(50)             null comment '单据号',
    VBILLSTATUS     int                     null comment '单据状态',
    PK_BUSITYPE     varchar(20)             null,
    BILLTYPE        varchar(4)              null comment '单据状态',
    PK_CORP         varchar(50)             null comment '所属公司',
    PK_AREA         varchar(20)             null comment '所属片区',
    DR              int                     null comment '删除标志',
    TS              varchar(19)             null comment '时间戳',
    PK_SMALLAREA    varchar(50)             not null comment '主键'
        primary key,
    SMALLAREANAME   varchar(50)             null comment '小区名称',
    PROTYPE         varchar(20)             null comment '物业类别',
    BUILDTYPE       varchar(20)             null comment '建筑类别',
    JOINDATE        varchar(19)             null comment '入伙时间',
    DEVELOPER       varchar(50)             null comment '开发商',
    SAREANUM        int                     null comment '小区户数',
    SAREATYPE       varchar(20)             null comment '小区户型',
    COVEREDAREANUM  decimal(20, 8)          null comment '占地面积',
    MADEAREANUM     decimal(20, 8)          null comment '建筑面积(m²)',
    PUBAREANUM      decimal(20, 8)          null comment '公共场所',
    GARAGEAREANUM   decimal(20, 8)          null comment '车库面积',
    PARKINGLOTNUM   int                     null comment '车位数量',
    OFFICEAREANUM   decimal(20, 8)          null comment '物业办公场所面积',
    REMAN           varchar(20)             null comment '负责人',
    MANGERPHONE     varchar(20)             null comment '管理处电话',
    CONCATMAN       varchar(20)             null comment '联系人',
    CONCATPHONE     varchar(20)             null comment '联系电话',
    BUILDYEAR       varchar(20)             null comment '建筑年代',
    FINISHDATE      varchar(19)             null comment '竣工时间',
    CONTAINRATE     decimal(20, 8)          null comment '容积率',
    GREENRATE       decimal(20, 8)          null comment '绿化率',
    PROFEE          decimal(20, 8)          null comment '物业费',
    PACKINGSPACE    varchar(20)             null comment '停车位',
    HOUSESTATE      text                    null comment '栋数及楼层情况',
    INTRODUCTION    text                    null comment '小区简介',
    VMEMO           text                    null comment '备注',
    SORTNO          int                     null comment '排序',
    SECLEVE         int                     null comment '密级',
    PK_OPERATOR     varchar(50)             null comment '制单人',
    DMAKEDATE       varchar(10)             null comment '制单日期',
    DMAKETIME       varchar(19)             null comment '制单时间',
    VAPPROVEID      varchar(20)             null comment '审核人',
    VAPPROVEDATE    varchar(10)             null comment '审核日期',
    ISLOCK          varchar(1)              null comment '是否锁定',
    LOCKMAN         varchar(20)             null comment '锁定人',
    LOCKDATE        varchar(10)             null comment '锁定日期',
    VDEF1           varchar(100)            null,
    VDEF2           varchar(100)            null,
    VDEF3           varchar(100)            null,
    VDEF4           varchar(100)            null,
    VDEF5           varchar(100)            null,
    VDEF6           varchar(100)            null,
    VDEF7           varchar(100)            null,
    VDEF8           varchar(100)            null,
    VDEF9           varchar(100)            null comment '住宅户数',
    VDEF10          varchar(100)            null comment '商铺户数',
    PK_HISTORY      varchar(20)             null,
    CLUBNUM         decimal(20, 8)          null,
    PLAYPONDNUM     decimal(20, 8)          null,
    KZHNUM          decimal(20, 8)          null,
    ZDYNUM          decimal(20, 8)          null,
    ZLCNUM          decimal(20, 8)          null,
    DROOMNUM        decimal(20, 8)          null,
    SKIRTNUM        decimal(20, 8)          null,
    TOWERNUM        decimal(20, 8)          null,
    SMALLAREACODE   varchar(50)             null,
    COUNTRYCODE     varchar(50)             null,
    PROVINCECODE    varchar(50)             null,
    CITYCODE        varchar(50)             null,
    AREACODE        varchar(50)             null,
    PK_MAP          varchar(50)             null,
    MAPLOCATION     text                    null,
    VPROFEE         varchar(200)            null,
    VDEF11          decimal(20, 8)          null,
    VDEF12          varchar(100)            null,
    LOCATION        varchar(100)            null comment '小区位置',
    THROUGHBUS      varchar(100)            null comment '途经本物业的公共汽车',
    COMMERCIALSPACE varchar(100)            null comment '商业面积',
    HOUSESPACE      varchar(100)            null comment '住宅面积',
    CLUBSPACE       varchar(100)            null comment '会所面积',
    OHTERSPACE      varchar(100)            null comment '其他面积',
    TOTALHOUSEHOLDS varchar(100)            null comment '总户数',
    ONEARTH         varchar(10)             null comment '地上停车位数量',
    UNDEREARTH      varchar(10)             null comment '地下停车位数量',
    CLOSEDCASE      varchar(100)            null comment '封闭情况',
    ENTRANCE        varchar(100)            null comment '入行出入口',
    CARDEALERS      varchar(100)            null comment '车行出入口',
    SWITCHGERROOM   varchar(100)            null comment '高低压配电室位置',
    GENERATORROOM   varchar(100)            null comment '发电机房位置',
    CNETRALROOM     varchar(100)            null comment '中央空调房位置',
    PUMPROOM        varchar(100)            null comment '水泵房位置',
    GASFIREROOM     varchar(100)            null comment '气体灭火室位置',
    VANTALORROOM    varchar(100)            null comment '风机房位置',
    LIFTROOM        varchar(100)            null comment '电梯机房位置',
    FIRECONTROL     varchar(100)            null comment '消防中心位置',
    HIGHNUM         varchar(100)            null comment '  小区高压线路号',
    OTHERIMPORTANT  varchar(100)            null comment '其他重要信息',
    CITYCOUNTYBM    varchar(100) default '' null comment '城市城区编码',
    ISJOIN          varchar(10)             null comment 'app获取(1：是，0：否)',
    DELIVERYDATE    varchar(20)             null comment '预计交房时间',
    PROJGUID        varchar(50)             null comment '明源中间库项目ID',
    RECEIVEDATE     varchar(20)             null,
    SFRH            varchar(10)             null comment '入伙状态(1：已入伙，0：未入伙)'
);

create index csh_smallarea_dr
    on csh_smallarea (DR);

create index csh_smallarea_pk_corp
    on csh_smallarea (PK_CORP, SMALLAREACODE);

create index csh_smallarea_vdef6
    on csh_smallarea (VDEF6);

create table csh_spjk_config
(
    ID            varchar(50)            not null comment '主键'
        primary key,
    CONNTYPE      varchar(5)             null comment '连接类别（1：固定IP方式，2：HiDDNS域名解析IP的方式）',
    SERVERADDRESS varchar(200)           null comment '服务器地址（连接类别：2，所需参数）',
    SERVERPORT    varchar(10)            null comment '服务器端口（连接类别：2，所需参数）',
    EQUIPFLAG     varchar(50)            null comment '设备标示（连接类别：2，所需参数）',
    IPADDRESS     varchar(50)            null comment '固定IP地址（连接类别：1，所需参数）',
    IPPORT        varchar(10)            null comment '固定IP端口',
    USERNAME      varchar(50)            null comment '用户名',
    PASSWORD      varchar(50)            null comment '密码',
    TS            char(19)               null comment '修改时间',
    PK_CORP       varchar(50)            null comment '组织机构ID',
    EQUIPPORT     varchar(50)            null comment '设备端口（连接类别：1，所需参数）',
    ISDELETED     varchar(2) default '0' null comment '删除标志位'
);

create table csh_zichan
(
    ID           varchar(32)  not null comment '资产主键ID'
        primary key,
    PK_CORP      varchar(50)  null comment '组织机构编码',
    PK_HOUSETYPE varchar(50)  null comment '楼宇PK',
    HOUSETYPENM  varchar(100) null comment '楼宇名称',
    CITYBM       varchar(32)  null comment '城市编码',
    CITYMC       varchar(50)  null comment '城市名称',
    ZCBM         varchar(100) null comment '资产编码',
    ZCZLBM       varchar(32)  null comment '资产总类主键编码',
    ZCZLMC       varchar(100) null comment '资产总类名称',
    ZCZLCODE     varchar(50)  null comment '资产总类编码',
    ZCLXBM       varchar(32)  null comment '资产类型主键编码',
    ZCLXMC       varchar(100) null comment '资产类型名称',
    ZCLXCODE     varchar(50)  null comment '资产类型编码',
    ZCMC         varchar(200) null comment '资产名称',
    CPFL         varchar(100) null comment '产品分类',
    ZCQS         varchar(100) null comment '资产权属',
    ZCSL         varchar(50)  null comment '资产数量',
    ZCMJ         varchar(50)  null comment '面积',
    XZYTBM       varchar(32)  null comment '性质用途编码',
    XZYTMC       varchar(50)  null comment '性质用途名称',
    HTQSSJ       date         null comment '合同起始时间',
    HTJSSJ       date         null comment '合同结束时间',
    HTDJ         varchar(50)  null comment '合同单价',
    HTZJ         varchar(50)  null comment '合同总价',
    HTYF         varchar(100) null comment '合同乙方',
    ZCWZ         varchar(100) null comment '资产位置',
    CQQK         varchar(100) null comment '产权情况',
    BZNR         varchar(500) null comment '备注内容',
    LRRYID       varchar(50)  null comment '录入人员ID',
    LRRYMC       varchar(50)  null comment '录入人员姓名',
    XGRYID       varchar(50)  null comment '最后更新人员ID',
    XGRYMC       varchar(50)  null comment '最后更新人员姓名',
    INSERTTIME   datetime     null comment '录入时间',
    UPDATETIME   datetime     null comment '最后更新时间',
    DEPTID       varchar(32)  null comment '组织机构主键',
    DEPTNAME     varchar(200) null comment '组织机构名称',
    ISDELETED    varchar(10)  null comment '删除标志（0：不删除，1：删除）'
)
    comment '资产合同信息表';

create table csh_zichan_lsjl
(
    ID           varchar(32)  not null comment '资产主键ID'
        primary key,
    ZCID         varchar(32)  null comment 'csh_zichan表的主键ID',
    PK_CORP      varchar(50)  null comment '组织机构编码',
    PK_HOUSETYPE varchar(50)  null comment '楼宇PK',
    HOUSETYPENM  varchar(100) null comment '楼宇名称',
    CITYBM       varchar(32)  null comment '城市编码',
    CITYMC       varchar(50)  null comment '城市名称',
    ZCBM         varchar(100) null comment '资产编码',
    ZCZLBM       varchar(32)  null comment '资产总类主键编码',
    ZCZLMC       varchar(100) null comment '资产总类名称',
    ZCZLCODE     varchar(50)  null comment '资产总类编码',
    ZCLXBM       varchar(32)  null comment '资产类型主键编码',
    ZCLXMC       varchar(100) null comment '资产类型名称',
    ZCLXCODE     varchar(50)  null comment '资产类型编码',
    ZCMC         varchar(200) null comment '资产名称',
    CPFL         varchar(100) null comment '产品分类',
    ZCQS         varchar(100) null comment '资产权属',
    ZCSL         varchar(50)  null comment '资产数量',
    ZCMJ         varchar(50)  null comment '面积',
    XZYTBM       varchar(32)  null comment '性质用途编码',
    XZYTMC       varchar(50)  null comment '性质用途名称',
    HTQSSJ       date         null comment '合同起始时间',
    HTJSSJ       date         null comment '合同结束时间',
    HTDJ         varchar(50)  null comment '合同单价',
    HTZJ         varchar(50)  null comment '合同总价',
    HTYF         varchar(100) null comment '合同乙方',
    ZCWZ         varchar(100) null comment '资产位置',
    CQQK         varchar(100) null comment '产权情况',
    BZNR         varchar(500) null comment '备注内容',
    LRRYID       varchar(50)  null comment '录入人员ID',
    LRRYMC       varchar(50)  null comment '录入人员姓名',
    XGRYID       varchar(50)  null comment '最后更新人员ID',
    XGRYMC       varchar(50)  null comment '最后更新人员姓名',
    INSERTTIME   datetime     null comment '录入时间',
    UPDATETIME   datetime     null comment '最后更新时间',
    DEPTID       varchar(32)  null comment '组织机构主键',
    DEPTNAME     varchar(200) null comment '组织机构名称',
    ISDELETED    varchar(10)  null comment '删除标志（0：不删除，1：删除）'
);

create table device_patrol
(
    patrol_id     varchar(32)  not null,
    device_id     varchar(32)  null comment '设备id',
    area          varchar(200) null comment '巡检地址',
    check_id      varchar(32)  null comment '巡检人',
    check_time    varchar(50)  null,
    handle_id     varchar(32)  null comment '维保人',
    handle_time   varchar(50)  null,
    patrol_status int(1)       null comment '状态',
    wb_id         varchar(32)  null,
    patrol_type   int(1)       null comment '1：安全巡逻；2：设备巡逻',
    patrol_url    varchar(200) null,
    patrol_text   varchar(500) null,
    patrol_image  varchar(500) null,
    uuid          varchar(32)  not null
        primary key
)
    comment '巡逻';

create table doc
(
    ID         int auto_increment
        primary key,
    DOCCONTENT longblob     null,
    DOCDATE    datetime     null,
    DOCID      varchar(255) null,
    DOCTITLE   varchar(255) null,
    DOCTYPE    varchar(255) null
);

create table housetypejoindate
(
    pk_corp      varchar(255) null,
    项目名称         varchar(255) null,
    pk_housetype varchar(255) not null
        primary key,
    楼栋           varchar(255) null,
    集中交付时间       varchar(255) null,
    joindate     datetime     null
);

create table jeecg_demo
(
    ID           varchar(32)    not null
        primary key,
    AGE          int            null,
    BIRTHDAY     datetime       null,
    content      varchar(255)   null,
    CREATE_TIME  datetime       null,
    DEP_ID       varchar(255)   null,
    EMAIL        varchar(255)   null,
    MOBILE_PHONE varchar(255)   null,
    OFFICE_PHONE varchar(255)   null,
    SALARY       decimal(19, 2) null,
    SEX          varchar(255)   null,
    status       varchar(255)   null,
    USER_NAME    varchar(255)   not null,
    create_date  datetime       null
);

create table jeecg_demo_teacher
(
    ID   varchar(32)  not null
        primary key,
    NAME varchar(12)  null,
    pic  varchar(255) null
);

create table jeecg_demo_course
(
    ID         varchar(32) not null
        primary key,
    NAME       varchar(25) null,
    teacher_ID varchar(32) null,
    constraint FK_g3jn8mfod69i7jfv5gnrcvgbx
        foreign key (teacher_ID) references jeecg_demo_teacher (ID)
);

create table jeecg_demo_student
(
    ID        varchar(32) not null
        primary key,
    BIRTHDAY  datetime    null,
    NAME      varchar(32) null,
    SEX       varchar(1)  null,
    COURSE_ID varchar(32) null,
    constraint FK_r86q81koyocgod3cx6529hbpw
        foreign key (COURSE_ID) references jeecg_demo_course (ID)
);

create table jeecg_matter_bom
(
    ID             varchar(32)    not null
        primary key,
    address        varchar(255)   null,
    code           varchar(50)    not null,
    name           varchar(50)    not null,
    price          decimal(21, 6) not null,
    productionDate datetime       null,
    quantity       int            not null,
    stock          int            not null,
    unit           varchar(50)    null,
    weight         varchar(50)    null,
    parent_ID      varchar(32)    null,
    constraint FK_fldfyrevj0li4hej5b2gu2q7w
        foreign key (parent_ID) references jeecg_matter_bom (ID)
);

create table jeecg_minidao
(
    ID           varchar(32)    not null
        primary key,
    AGE          int            null,
    BIRTHDAY     datetime       null,
    CONTENT      varchar(255)   null,
    CREATE_TIME  datetime       null,
    DEP_ID       varchar(255)   null,
    EMAIL        varchar(255)   null,
    MOBILE_PHONE varchar(255)   null,
    OFFICE_PHONE varchar(255)   null,
    SALARY       decimal(19, 2) null,
    SEX          int            null,
    STATUS       varchar(255)   null,
    USER_NAME    varchar(255)   not null
);

create table jeecg_order_custom
(
    ID                varchar(32)  not null
        primary key,
    CREATE_DT         datetime     null,
    CRTUSER           varchar(12)  null,
    CRTUSER_NAME      varchar(10)  null,
    DEL_DT            datetime     null,
    DELFLAG           int          null,
    GO_ORDER_CODE     varchar(12)  not null,
    GOC_BUSS_CONTENT  varchar(33)  null,
    GOC_CONTENT       varchar(66)  null,
    GOC_CUS_NAME      varchar(16)  null,
    GOC_IDCARD        varchar(18)  null,
    GOC_PASSPORT_CODE varchar(10)  null,
    GOC_SEX           varchar(255) null,
    MODIFIER          varchar(12)  null,
    MODIFIER_NAME     varchar(10)  null,
    MODIFY_DT         datetime     null
);

create table jeecg_order_main
(
    ID              varchar(32)    not null
        primary key,
    CREATE_DT       datetime       null,
    CRTUSER         varchar(12)    null,
    CRTUSER_NAME    varchar(10)    null,
    DEL_DT          datetime       null,
    DELFLAG         int            null,
    GO_ALL_PRICE    decimal(10, 2) null,
    GO_CONTACT_NAME varchar(16)    null,
    GO_CONTENT      varchar(66)    null,
    GO_ORDER_CODE   varchar(12)    not null,
    GO_ORDER_COUNT  int            null,
    GO_RETURN_PRICE decimal(10, 2) null,
    GO_TELPHONE     varchar(11)    null,
    GODER_TYPE      varchar(255)   null,
    MODIFIER        varchar(12)    null,
    MODIFIER_NAME   varchar(10)    null,
    MODIFY_DT       datetime       null,
    USERTYPE        varchar(255)   null
);

create table jeecg_order_product
(
    ID               varchar(32)    not null
        primary key,
    CREATE_DT        datetime       null,
    CRTUSER          varchar(12)    null,
    CRTUSER_NAME     varchar(10)    null,
    DEL_DT           datetime       null,
    DELFLAG          int            null,
    GO_ORDER_CODE    varchar(12)    not null,
    GOP_CONTENT      varchar(66)    null,
    GOP_COUNT        int            null,
    GOP_ONE_PRICE    decimal(10, 2) null,
    GOP_PRODUCT_NAME varchar(33)    null,
    GOP_PRODUCT_TYPE varchar(1)     not null,
    GOP_SUM_PRICE    decimal(10, 2) null,
    MODIFIER         varchar(12)    null,
    MODIFIER_NAME    varchar(10)    null,
    MODIFY_DT        datetime       null
);

create table jform_cgreport_head
(
    ID      varchar(36)  not null
        primary key,
    CGR_SQL longtext     not null,
    CODE    varchar(36)  not null,
    CONTENT longtext     not null,
    NAME    varchar(100) not null
);

create table jform_cgreport_item
(
    ID         varchar(36)  not null
        primary key,
    S_FLAG     varchar(2)   null,
    S_MODE     varchar(10)  null,
    CGRHEAD_ID varchar(36)  null,
    DICT_CODE  varchar(36)  null,
    FIELD_HREF varchar(120) null,
    FIELD_NAME varchar(36)  null,
    FIELD_TXT  longtext     null,
    FIELD_TYPE varchar(10)  null,
    IS_SHOW    varchar(5)   null,
    ORDER_NUM  int          null,
    REPLACE_VA varchar(36)  null
);

create table jform_leave
(
    id         varchar(36)  not null
        primary key,
    title      varchar(50)  not null comment '请假标题',
    people     varchar(20)  not null comment '请假人',
    sex        varchar(10)  not null comment '性别',
    begindate  datetime     not null comment '请假开始时间',
    enddate    datetime     not null comment '请假结束时间',
    day_num    int          null comment '请假天数',
    hol_dept   varchar(32)  not null comment '所属部门',
    hol_reson  varchar(255) not null comment '请假原因',
    dep_leader varchar(20)  not null comment '部门审批人',
    content    varchar(255) not null comment '部门审批意见'
);

create table jform_order_main
(
    id          varchar(36)  not null
        primary key,
    order_code  varchar(50)  null comment '订单号',
    order_date  datetime     null comment '订单日期',
    order_money double       null comment '订单金额',
    content     varchar(255) null comment '备注'
);

create table jg_person
(
    ID       varchar(32)    not null
        primary key,
    AGE      int            null,
    BIRTHDAY datetime       null,
    CREATEDT datetime       null,
    NAME     varchar(255)   not null,
    SALARY   decimal(19, 2) null
);

create table knowledge_base
(
    know_id      varchar(32)  not null comment '知识库id'
        primary key,
    know_type_id varchar(32)  null comment '知识库类别（关联数据字典）',
    title        varchar(100) null comment '知识库标题',
    detail       varchar(500) null comment '知识库内容',
    url          varchar(100) null comment '知识库url',
    modify_time  datetime     null,
    update_time  datetime     null,
    know_txt     varchar(100) null,
    publish_user varchar(32)  null,
    publish_time varchar(32)  null
)
    comment '知识库';

create table knowledge_base_type
(
    know_type_id varchar(32)  not null comment '知识库id'
        primary key,
    type_name    varchar(100) null comment '知识库标题',
    parent_id    varchar(500) null comment '知识库内容',
    modify_time  datetime     null,
    update_time  datetime     null
)
    comment '知识库类别';

create table moa_nrgl
(
    ID         varchar(32) default ''  not null
        primary key,
    XXNRBT     varchar(100)            null comment '信息内容标题',
    XXNR       longtext                null comment '信息内容',
    XXLBID     varchar(32)             null comment '信息类别ID',
    XXLBMC     varchar(50)             null comment '信息类别名称',
    NRLJ       varchar(1024)           null comment '内容链接',
    FBRY       varchar(50)             null comment '发布人员',
    GK         varchar(10)             null comment '是否发布（1：发布，0：不发布）',
    MB         varchar(10)             null comment '是否为模版（1：是，0：否）',
    DEPTID     varchar(50)             null comment '部门id（只能本项目的业主才能查看，单一项目）多个项目的情况再设计另外的关系表确定',
    DEPTNAME   varchar(50)             null comment '部门名称',
    READNUM    int                     null comment '阅读次数',
    GZHDEPTID  varchar(32)             null comment '公众号单位',
    LRRYID     varchar(32)             null comment '录入人员ID',
    LRRYMC     varchar(10)             null comment '录入人员姓名',
    LRRYDEPTID varchar(32)             null comment '录入人员部门ID',
    LRRYDEPTMC varchar(100)            null comment '录入人员部门全称',
    LRRQ       timestamp               null comment '录入时间',
    UPDATETIME timestamp               null comment '更新时间',
    ISDELETED  varchar(1)  default '0' not null comment '删除标示（0：不删除，1：删除）'
)
    comment '内容发布管理' charset = gbk;

create table moa_nrlb
(
    ID         varchar(32) default ''  not null
        primary key,
    XXLB       varchar(50)             null comment '信息类别名称',
    SORT       int                     null comment '排序',
    LRRYID     varchar(32)             null comment '录入人员ID',
    LRRYMC     varchar(10)             null comment '录入人员姓名',
    LRRYDEPTID varchar(32)             null comment '录入人员部门ID',
    LRRYDEPTMC varchar(100)            null comment '录入人员部门全称',
    LRRQ       timestamp               null comment '录入时间',
    UPDATETIME timestamp               null comment '更新时间',
    ISDELETED  varchar(1)  default '0' not null comment '删除标示（0：不删除，1：删除）'
)
    comment '内容信息类别' charset = gbk;

create table moa_nrmb
(
    ID     varchar(32) default '' not null
        primary key,
    MBNR   longtext               null comment '模版内容信息',
    XXLBID varchar(32)            null comment '信息类别ID',
    MBBT   varchar(100)           null comment '模版标题',
    MBMS   varchar(500)           null comment '模版描述',
    SORT   int                    null comment '排序'
)
    comment '内容信息模版' charset = gbk;

create table mybusinessunit_import
(
    BUGUID             char(36)     not null,
    BUName             varchar(50)  null,
    BUFullName         varchar(100) null,
    BUCode             varchar(50)  null,
    HierarchyCode      text         null,
    ParentGUID         char(36)     null,
    IsEndCompany       tinyint      null,
    IsCompany          tinyint      null,
    Level              int          null,
    BUType             tinyint      null,
    ProjGUID           char(36)     null,
    OrderCode          varchar(20)  null,
    OrderHierarchyCode text         null,
    CompanyGUID        char(36)     null,
    ImportFlag         varchar(10)  not null,
    constraint idxBUGUID
        unique (BUGUID)
);

alter table mybusinessunit_import
    add primary key (BUGUID);

create table optimistic_locking
(
    ID      varchar(32) not null
        primary key,
    ACCOUNT int         null,
    AGE     int         null,
    NAME    varchar(85) null,
    VER     int         null
);

create table p_building_import
(
    BldGUID     char(36)     not null,
    BUGUID      char(36)     not null,
    ProjGUID    char(36)     not null,
    BldCode     varchar(30)  null,
    BldName     varchar(100) null,
    ParentCode  varchar(60)  null,
    BldFullName text         null,
    UnitNum     int          null,
    FloorNum    int          null,
    ImportFlag  varchar(10)  not null,
    constraint idxBldGUID
        unique (BldGUID)
);

create index idxImportFlag
    on p_building_import (ImportFlag);

create index idxProjGUID
    on p_building_import (ProjGUID);

alter table p_building_import
    add primary key (BldGUID);

create table p_building_import_bk_03_06
(
    BldGUID     char(36)     not null,
    BUGUID      char(36)     not null,
    ProjGUID    char(36)     not null,
    BldCode     varchar(30)  null,
    BldName     varchar(100) null,
    ParentCode  varchar(60)  null,
    BldFullName text         null,
    UnitNum     int          null,
    FloorNum    int          null,
    ImportFlag  varchar(10)  not null
);

create table p_cstattribute_import
(
    CstGUID    char(36)    not null,
    Marriage   text        null,
    ImportFlag varchar(10) not null
);

create index idxCstGUID
    on p_cstattribute_import (CstGUID);

create table p_cstattribute_import_bk_03_06
(
    CstGUID    char(36)    not null,
    Marriage   text        null,
    ImportFlag varchar(10) not null
);

create table p_customer_import
(
    CstGUID     char(36)     not null,
    CstName     varchar(60)  null,
    CardID      varchar(30)  null,
    MobileTel   varchar(30)  null,
    Address     varchar(200) null,
    Gender      varchar(10)  null,
    CardType    varchar(10)  null,
    NativePlace varchar(100) null,
    CardID15    varchar(40)  null,
    BirthDate   datetime     null,
    ImportFlag  varchar(10)  not null,
    constraint idxCstGUID
        unique (CstGUID)
);

create index idxImportFlag
    on p_customer_import (ImportFlag);

alter table p_customer_import
    add primary key (CstGUID);

create table p_customer_import_bk_03_06
(
    CstGUID     char(36)     not null,
    CstName     varchar(60)  null,
    CardID      varchar(30)  null,
    MobileTel   varchar(30)  null,
    Address     varchar(200) null,
    Gender      varchar(10)  null,
    CardType    varchar(10)  null,
    NativePlace varchar(100) null,
    CardID15    varchar(40)  null,
    BirthDate   datetime     null,
    ImportFlag  varchar(10)  not null
);

create table p_project_import
(
    ProjGUID      char(36)       not null,
    BUGUID        char(36)       null,
    ProjCode      varchar(100)   null,
    ProjName      text           null,
    OccupyArea    decimal(19, 4) null,
    BuildArea     decimal(19, 4) null,
    Rjl           decimal(19, 4) null,
    BusArea       decimal(19, 4) null,
    HouseArea     decimal(19, 4) null,
    ParentCode    varchar(40)    null,
    Level         tinyint        null,
    IfEnd         tinyint        null,
    ProjShortCode varchar(20)    null,
    ProjShortName varchar(40)    null,
    ApplySys      varchar(100)   null,
    ImportFlag    varchar(10)    not null,
    ZYID          varchar(32)    null,
    constraint idxProjGUID
        unique (ProjGUID)
);

create index idxImportFlag
    on p_project_import (ImportFlag);

alter table p_project_import
    add primary key (ProjGUID);

create table p_project_import_bk_03_06
(
    ProjGUID      char(36)       not null,
    BUGUID        char(36)       null,
    ProjCode      varchar(100)   null,
    ProjName      text           null,
    OccupyArea    decimal(19, 4) null,
    BuildArea     decimal(19, 4) null,
    Rjl           decimal(19, 4) null,
    BusArea       decimal(19, 4) null,
    HouseArea     decimal(19, 4) null,
    ParentCode    varchar(40)    null,
    Level         tinyint        null,
    IfEnd         tinyint        null,
    ProjShortCode varchar(20)    null,
    ProjShortName varchar(40)    null,
    ApplySys      varchar(100)   null,
    ImportFlag    varchar(10)    not null,
    ZYID          varchar(32)    null
);

create table p_room_import
(
    RoomGUID    char(36)       not null,
    ProjGUID    char(36)       null,
    BldGUID     char(36)       null,
    Unit        varchar(10)    null,
    Floor       varchar(10)    null,
    No          varchar(10)    null,
    Room        varchar(100)   null,
    RoomCode    varchar(200)   null,
    HuXing      varchar(10)    null,
    YsBldArea   decimal(19, 4) null,
    YsTnArea    decimal(19, 4) null,
    ScBldArea   decimal(19, 4) null,
    ScTnArea    decimal(19, 4) null,
    CstGUIDList text           null,
    ImportFlag  varchar(10)    not null,
    constraint idxRoomGUID
        unique (RoomGUID)
);

create index idxBldGUID
    on p_room_import (BldGUID);

create index idxImportFlag
    on p_room_import (ImportFlag);

create index idxProjGUID
    on p_room_import (ProjGUID);

alter table p_room_import
    add primary key (RoomGUID);

create table p_room_import_bk_03_06
(
    RoomGUID    char(36)       not null,
    ProjGUID    char(36)       null,
    BldGUID     char(36)       null,
    Unit        varchar(10)    null,
    Floor       varchar(10)    null,
    No          varchar(10)    null,
    Room        varchar(100)   null,
    RoomCode    varchar(200)   null,
    HuXing      varchar(10)    null,
    YsBldArea   decimal(19, 4) null,
    YsTnArea    decimal(19, 4) null,
    ScBldArea   decimal(19, 4) null,
    ScTnArea    decimal(19, 4) null,
    CstGUIDList text           null,
    ImportFlag  varchar(10)    not null
);

create table patrol_plan
(
    plan_id         varchar(32)  null,
    plan_name       varchar(255) null,
    plan_begin_time varchar(50)  null,
    paln_end_time   varchar(50)  null,
    patrol_point_id varchar(32)  null comment '巡逻路线id',
    real_begin_time varchar(50)  null,
    real_end_time   varchar(50)  null,
    update_time     varchar(50)  null,
    plan_status     varchar(50)  null comment '启用  停止',
    plan_proc       varchar(255) null
)
    comment '巡逻方案';

create table patrol_point
(
    patrol_id     varchar(32)  not null
        primary key,
    patrol_name   varchar(100) null comment '路线名称',
    patrol_status varchar(10)  null comment '有效 无效',
    patrol_time   varchar(50)  null comment '巡逻时间',
    patrol_order  varchar(100) null comment '是否有序  有序 无序',
    remark        varchar(255) null,
    create_time   varchar(50)  null,
    update_time   varchar(50)  null,
    patrol_level  varchar(100) null comment '重量级别'
)
    comment '巡逻点';

create table patrol_safe
(
    uuid            varchar(32)  not null
        primary key,
    user_id         varchar(32)  null,
    patrol_id       varchar(32)  null,
    patrol_area     varchar(255) null,
    puuid           varchar(32)  null,
    patrol_order    int(3)       null,
    patrol_point_id varchar(32)  null,
    update_time     varchar(50)  null
)
    comment '巡逻路线表';

create table qrtz_calendars
(
    SCHED_NAME    varchar(120) not null,
    CALENDAR_NAME varchar(200) not null,
    CALENDAR      blob         not null,
    primary key (SCHED_NAME, CALENDAR_NAME)
);

create table qrtz_fired_triggers
(
    SCHED_NAME        varchar(120) not null,
    ENTRY_ID          varchar(95)  not null,
    TRIGGER_NAME      varchar(200) not null,
    TRIGGER_GROUP     varchar(200) not null,
    INSTANCE_NAME     varchar(200) not null,
    FIRED_TIME        bigint(13)   not null,
    SCHED_TIME        bigint(13)   not null,
    PRIORITY          int          not null,
    STATE             varchar(16)  not null,
    JOB_NAME          varchar(200) null,
    JOB_GROUP         varchar(200) null,
    IS_NONCONCURRENT  varchar(1)   null,
    REQUESTS_RECOVERY varchar(1)   null,
    primary key (SCHED_NAME, ENTRY_ID)
);

create index IDX_QRTZ_FT_INST_JOB_REQ_RCVRY
    on qrtz_fired_triggers (SCHED_NAME, INSTANCE_NAME, REQUESTS_RECOVERY);

create index IDX_QRTZ_FT_JG
    on qrtz_fired_triggers (SCHED_NAME, JOB_GROUP);

create index IDX_QRTZ_FT_J_G
    on qrtz_fired_triggers (SCHED_NAME, JOB_NAME, JOB_GROUP);

create index IDX_QRTZ_FT_TG
    on qrtz_fired_triggers (SCHED_NAME, TRIGGER_GROUP);

create index IDX_QRTZ_FT_TRIG_INST_NAME
    on qrtz_fired_triggers (SCHED_NAME, INSTANCE_NAME);

create index IDX_QRTZ_FT_T_G
    on qrtz_fired_triggers (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP);

create table qrtz_job_details
(
    SCHED_NAME        varchar(120) not null,
    JOB_NAME          varchar(200) not null,
    JOB_GROUP         varchar(200) not null,
    DESCRIPTION       varchar(250) null,
    JOB_CLASS_NAME    varchar(250) not null,
    IS_DURABLE        varchar(1)   not null,
    IS_NONCONCURRENT  varchar(1)   not null,
    IS_UPDATE_DATA    varchar(1)   not null,
    REQUESTS_RECOVERY varchar(1)   not null,
    JOB_DATA          blob         null,
    primary key (SCHED_NAME, JOB_NAME, JOB_GROUP)
);

create index IDX_QRTZ_J_GRP
    on qrtz_job_details (SCHED_NAME, JOB_GROUP);

create index IDX_QRTZ_J_REQ_RECOVERY
    on qrtz_job_details (SCHED_NAME, REQUESTS_RECOVERY);

create table qrtz_locks
(
    SCHED_NAME varchar(120) not null,
    LOCK_NAME  varchar(40)  not null,
    primary key (SCHED_NAME, LOCK_NAME)
);

create table qrtz_paused_trigger_grps
(
    SCHED_NAME    varchar(120) not null,
    TRIGGER_GROUP varchar(200) not null,
    primary key (SCHED_NAME, TRIGGER_GROUP)
);

create table qrtz_scheduler_state
(
    SCHED_NAME        varchar(120) not null,
    INSTANCE_NAME     varchar(200) not null,
    LAST_CHECKIN_TIME bigint(13)   not null,
    CHECKIN_INTERVAL  bigint(13)   not null,
    primary key (SCHED_NAME, INSTANCE_NAME)
);

create table qrtz_triggers
(
    SCHED_NAME     varchar(120) not null,
    TRIGGER_NAME   varchar(200) not null,
    TRIGGER_GROUP  varchar(200) not null,
    JOB_NAME       varchar(200) not null,
    JOB_GROUP      varchar(200) not null,
    DESCRIPTION    varchar(250) null,
    NEXT_FIRE_TIME bigint(13)   null,
    PREV_FIRE_TIME bigint(13)   null,
    PRIORITY       int          null,
    TRIGGER_STATE  varchar(16)  not null,
    TRIGGER_TYPE   varchar(8)   not null,
    START_TIME     bigint(13)   not null,
    END_TIME       bigint(13)   null,
    CALENDAR_NAME  varchar(200) null,
    MISFIRE_INSTR  smallint(2)  null,
    JOB_DATA       blob         null,
    primary key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    constraint QRTZ_TRIGGERS_ibfk_1
        foreign key (SCHED_NAME, JOB_NAME, JOB_GROUP) references qrtz_job_details (SCHED_NAME, JOB_NAME, JOB_GROUP)
);

create table qrtz_blob_triggers
(
    SCHED_NAME    varchar(120) not null,
    TRIGGER_NAME  varchar(200) not null,
    TRIGGER_GROUP varchar(200) not null,
    BLOB_DATA     blob         null,
    primary key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    constraint QRTZ_BLOB_TRIGGERS_ibfk_1
        foreign key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) references qrtz_triggers (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
);

create index SCHED_NAME
    on qrtz_blob_triggers (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP);

create table qrtz_cron_triggers
(
    SCHED_NAME      varchar(120) not null,
    TRIGGER_NAME    varchar(200) not null,
    TRIGGER_GROUP   varchar(200) not null,
    CRON_EXPRESSION varchar(120) not null,
    TIME_ZONE_ID    varchar(80)  null,
    primary key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    constraint QRTZ_CRON_TRIGGERS_ibfk_1
        foreign key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) references qrtz_triggers (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
);

create table qrtz_simple_triggers
(
    SCHED_NAME      varchar(120) not null,
    TRIGGER_NAME    varchar(200) not null,
    TRIGGER_GROUP   varchar(200) not null,
    REPEAT_COUNT    bigint(7)    not null,
    REPEAT_INTERVAL bigint(12)   not null,
    TIMES_TRIGGERED bigint(10)   not null,
    primary key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    constraint QRTZ_SIMPLE_TRIGGERS_ibfk_1
        foreign key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) references qrtz_triggers (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
);

create table qrtz_simprop_triggers
(
    SCHED_NAME    varchar(120)   not null,
    TRIGGER_NAME  varchar(200)   not null,
    TRIGGER_GROUP varchar(200)   not null,
    STR_PROP_1    varchar(512)   null,
    STR_PROP_2    varchar(512)   null,
    STR_PROP_3    varchar(512)   null,
    INT_PROP_1    int            null,
    INT_PROP_2    int            null,
    LONG_PROP_1   bigint         null,
    LONG_PROP_2   bigint         null,
    DEC_PROP_1    decimal(13, 4) null,
    DEC_PROP_2    decimal(13, 4) null,
    BOOL_PROP_1   varchar(1)     null,
    BOOL_PROP_2   varchar(1)     null,
    primary key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    constraint QRTZ_SIMPROP_TRIGGERS_ibfk_1
        foreign key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) references qrtz_triggers (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
);

create index IDX_QRTZ_T_C
    on qrtz_triggers (SCHED_NAME, CALENDAR_NAME);

create index IDX_QRTZ_T_G
    on qrtz_triggers (SCHED_NAME, TRIGGER_GROUP);

create index IDX_QRTZ_T_J
    on qrtz_triggers (SCHED_NAME, JOB_NAME, JOB_GROUP);

create index IDX_QRTZ_T_JG
    on qrtz_triggers (SCHED_NAME, JOB_GROUP);

create index IDX_QRTZ_T_NEXT_FIRE_TIME
    on qrtz_triggers (SCHED_NAME, NEXT_FIRE_TIME);

create index IDX_QRTZ_T_NFT_MISFIRE
    on qrtz_triggers (SCHED_NAME, MISFIRE_INSTR, NEXT_FIRE_TIME);

create index IDX_QRTZ_T_NFT_ST
    on qrtz_triggers (SCHED_NAME, TRIGGER_STATE, NEXT_FIRE_TIME);

create index IDX_QRTZ_T_NFT_ST_MISFIRE
    on qrtz_triggers (SCHED_NAME, MISFIRE_INSTR, NEXT_FIRE_TIME, TRIGGER_STATE);

create index IDX_QRTZ_T_NFT_ST_MISFIRE_GRP
    on qrtz_triggers (SCHED_NAME, MISFIRE_INSTR, NEXT_FIRE_TIME, TRIGGER_GROUP, TRIGGER_STATE);

create index IDX_QRTZ_T_N_G_STATE
    on qrtz_triggers (SCHED_NAME, TRIGGER_GROUP, TRIGGER_STATE);

create index IDX_QRTZ_T_N_STATE
    on qrtz_triggers (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP, TRIGGER_STATE);

create index IDX_QRTZ_T_STATE
    on qrtz_triggers (SCHED_NAME, TRIGGER_STATE);

create table schedule_job_config
(
    id              bigint auto_increment comment '任务id'
        primary key,
    bean_name       varchar(200)                       null comment 'spring bean名称',
    method_name     varchar(100)                       null comment '方法名',
    params          varchar(2000)                      null comment '参数',
    cron_expression varchar(100)                       null comment 'cron表达式',
    status          tinyint  default 1                 null comment '任务状态(1：正常，0：暂停)',
    remark          varchar(255)                       null comment '备注',
    create_time     datetime default CURRENT_TIMESTAMP null comment '创建时间'
)
    comment '定时任务配置';

create table sheet1
(
    姓名           varchar(255) null,
    所属区域         varchar(255) null,
    所属项目         varchar(255) null,
    联系方式         varchar(255) null,
    是否使用资源系统     varchar(255) null,
    是否使用工单       varchar(255) null,
    仅开通员工APP功能   varchar(255) null,
    是否已开通资源或工单系统 varchar(255) null,
    资源系统账号       varchar(255) null,
    工单系统账号       varchar(255) null,
    deptid       varchar(255) null,
    upass        varchar(255) null,
    ID           varchar(255) not null
        primary key,
    USERROLE_ID  varchar(255) null
);

create table sheet1_dics
(
    ID         varchar(255) default '' not null
        primary key,
    DPID       varchar(255)            null,
    DSORT      varchar(255)            null,
    DCODE      varchar(255)            null,
    DSNAME     varchar(255)            null,
    DLNAME     varchar(255)            null,
    DFZ        varchar(255)            null,
    DXS        varchar(255)            null,
    DBZ        varchar(255)            null,
    CSSJ1      varchar(255)            null,
    CSSJ2      varchar(255)            null,
    CSSJ3      varchar(255)            null,
    CSBZ       varchar(255)            null,
    CSBZ2      varchar(255)            null,
    CSBZ3      varchar(255)            null,
    DLVL       varchar(255)            null,
    LEAF       varchar(255)            null,
    UPDATETIME varchar(255)            null,
    ISDELETED  varchar(255)            null,
    F20        varchar(255)            null
);

create table sys_adm_loginlog
(
    ID            varchar(32) not null comment '登录日志ID'
        primary key,
    USERID        varchar(32) null comment '登录用户ID',
    IP            varchar(50) null comment '登录用户IP',
    LOGINDATE     datetime    null comment '登录时间',
    USERAGENT     longtext    null comment '登录用户浏览器信息',
    USERLOGINNAME varchar(50) null comment '登录用户名',
    USERNAME      varchar(50) null comment '登录用户姓名',
    LOGINRESULT   varchar(50) null comment '登录结果（0：失败，1：成功）',
    SCREENW       int         null comment '登录用户屏幕宽度',
    SCREENH       int         null comment '登录用户屏幕高度',
    CLIENTW       int         null comment '登录用户浏览器宽度',
    CLIENTH       int         null comment '登录用户浏览器高度'
)
    comment '系统框架后台用户登录日志表';

create table sys_adm_res
(
    ID         varchar(32)  not null comment '资源ID'
        primary key,
    RPID       varchar(32)  not null comment '上级资源ID，0表示根节点',
    RSORT      int          null comment '资源顺序',
    RCODE      varchar(40)  null comment '资源编号',
    RNAME      varchar(100) null comment '资源名称',
    RPATH      varchar(200) null comment '资源路径',
    RNOTE      text         null comment '资源备注',
    RTYPE      varchar(100) null comment '资源类型',
    UPDATETIME datetime     not null comment '更新时间',
    RLVL       int          null comment '资源级别，root：0',
    LEAF       int          null comment '是否为叶子节点（是：1，否：0）'
)
    comment '系统框架管理资源表';

create table sys_adm_user
(
    ID         varchar(32)  not null comment '用户ID'
        primary key,
    UUSER      varchar(20)  not null comment '用户名',
    UPASS      varchar(32)  not null comment '密码',
    UNAME      varchar(20)  null comment '姓名',
    USEX       varchar(10)  null comment '性别',
    UEMAIL     varchar(100) null comment 'email',
    UMOBILE    varchar(20)  null comment '手机号',
    UIP        varchar(200) null comment 'IP地址',
    UNOTE      text         null comment '备注',
    DEPTID     varchar(32)  null comment '部门ID',
    UPOSITION  varchar(50)  null comment '岗位',
    ISVALID    varchar(1)   not null comment '是否有效：1:有效, 0:无效',
    UBIRTHDAY  datetime     null comment '出生日期',
    UPDATETIME datetime     null comment '更新时间',
    QQ         varchar(50)  null comment 'QQ号',
    WX         varchar(200) null comment '微信号'
)
    comment '系统框架管理用户表';

create table sys_adm_user_res
(
    ID         varchar(32) not null comment 'ID'
        primary key,
    AU_ID      varchar(32) not null comment '管理用户ID',
    AR_ID      varchar(32) not null comment '管理资源ID',
    UPDATETIME datetime    not null comment '更新时间'
)
    comment '系统框架管理资源与管理用户关系表';

create table sys_data_dict
(
    data_id     varchar(32)  not null
        primary key,
    data_lable  varchar(50)  null comment '标签',
    data_name   varchar(255) null comment '字典名称',
    modift_time datetime     null,
    update_time datetime     null
)
    comment '数据字典';

create table sys_dept
(
    ID         varchar(32)  not null comment '部门ID',
    DPID       varchar(32)  not null comment '上级部门ID，0表示根节点',
    DSORT      int          null comment '部门序号',
    DCODE      varchar(40)  null comment '部门编号',
    DSNAME     varchar(50)  null comment '部门名称-简称short',
    DLNAME     varchar(120) null comment '部门名称-全称long',
    DADD       varchar(200) null comment '部门地址',
    DZIPCODE   varchar(40)  null comment '部门邮编',
    DTELE      varchar(40)  null comment '部门电话',
    DFAX       varchar(40)  null comment '部门传真',
    DEMAIL     varchar(200) null comment '部门email',
    DTYPE      varchar(32)  null comment '部门类别',
    DLVL       int          null comment '部门级别，root：0',
    LEAF       int          null comment '是否为叶子节点（是：1，否：0）',
    WXQYHDID   varchar(255) null,
    UPDATETIME datetime     not null comment '更新时间',
    ISDELETED  varchar(1)   null comment '删除标示（0：不删除，1：删除）',
    constraint sys_dept_key_id
        unique (ID)
)
    comment '系统框架部门表';

create index DPID
    on sys_dept (DPID);

create index sys_dept_dadd
    on sys_dept (DADD);

create index sys_dept_dcode
    on sys_dept (DCODE);

create index sys_dept_isdeleted
    on sys_dept (ISDELETED);

alter table sys_dept
    add primary key (ID);

create definer = logan@`%` trigger update_dsname
    after update
    on sys_dept
    for each row
begin
    -- if new.dsname!=old.dsname then
    update csh_smallarea set vdef6=new.dsname where pk_corp = new.dcode;
    update csh_housetype set vdef5=new.dsname where pk_corp = new.dcode;
-- end if;
end;

create table sys_dics
(
    ID         varchar(32)  not null comment '字典ID'
        primary key,
    DPID       varchar(32)  not null comment '上级字典ID，0表示根节点',
    DSORT      int          null comment '字典序号',
    DCODE      varchar(40)  null comment '字典编码',
    DSNAME     varchar(50)  null comment '字典名称-简称short',
    DLNAME     varchar(120) null comment '字典名称-全称long',
    DFZ        varchar(50)  null comment '分值',
    DXS        varchar(50)  null comment '系数',
    DBZ        varchar(200) null comment '备注',
    CSSJ1      int          null comment '项目级超时时间（分钟）',
    CSSJ2      int          null comment '区域级超时时间（分钟）',
    CSSJ3      int          null comment '总公司级超时时间（分钟）',
    CSBZ       int          null comment '超时备注判断时间（分钟），关单1级超时',
    CSBZ2      int          null comment '关单2级超时',
    CSBZ3      int          null comment '关单3级超时',
    DLVL       int          null comment '字典级别，root：0',
    LEAF       int          null comment '是否为叶子节点（是：1，否：0）',
    UPDATETIME datetime     not null comment '更新时间',
    ISDELETED  varchar(1)   null comment '删除标示（0：不删除，1：删除）'
)
    comment '微信物业平台类别字典表';

create table sys_loginlog
(
    ID            varchar(32) not null comment '登录日志ID'
        primary key,
    USERID        varchar(32) null comment '登录用户ID',
    IP            varchar(50) null comment '用户IP',
    LOGINDATE     datetime    null comment '登录时间',
    USERAGENT     text        null comment '登录用户浏览器信息',
    LOGINRESULT   text        null comment '登录结果（0：失败，1：成功）',
    DEPTID        varchar(32) null comment '登录用户部门ID',
    DEPTSNAME     text        null comment '登录用户本级部门简称',
    DEPTLNAME     text        null comment '登录用户本级部门全称',
    DEPTJSNAME    text        null comment '登录用户上级和本级部门简称',
    DEPTJLNAME    text        null comment '登录用户上级和本级部门全称',
    USERLOGINNAME varchar(50) null comment '登录用户名',
    USERNAME      varchar(50) null comment '登录用户姓名',
    SCREENW       int         null comment '登录用户屏幕宽度',
    SCREENH       int         null comment '登录用户屏幕高度',
    CLIENTW       int         null comment '登录用户浏览器宽度',
    CLIENTH       int         null comment '登录用户浏览器高度'
)
    comment '系统框架用户登录日志表';

create index sys_loginlog_idx1
    on sys_loginlog (LOGINDATE);

create index sys_loginlog_idx2
    on sys_loginlog (DEPTID);

create table sys_operation_log
(
    id           bigint unsigned auto_increment comment '主键ID'
        primary key,
    user_account varchar(20)      null comment '操作用户账号',
    user_name    varchar(20)      null comment '操作用户姓名',
    dept_id      varchar(32)      null comment '操作用户部门ID',
    dept_name    varchar(500)     null comment '操作用户部门名称',
    ope_type     tinyint unsigned null comment '操作类型（1-新增，2-修改，3-删除）',
    ope_module   tinyint unsigned null comment '操作模块（1-项目，2-楼栋，3-房产客户）',
    ope_detail   varchar(5000)    null comment '操作明细',
    params       varchar(5000)    null comment '请求参数',
    ip           varchar(50)      null comment 'IP地址',
    exe_time     bigint unsigned  null comment '执行时长(毫秒)',
    create_time  datetime         null comment '创建时间'
)
    comment '系统操作日志';

create index idx_user_account
    on sys_operation_log (user_account);

create table sys_res
(
    ID         varchar(32)              not null comment '资源ID'
        primary key,
    RPID       varchar(32)              not null comment '上级资源ID，0表示根节点',
    RSORT      int                      null comment '资源顺序',
    RCODE      varchar(40)              null comment '资源编号',
    RNAME      varchar(100)             null comment '资源名称',
    RPATH      varchar(200)             null comment '资源路径',
    RNOTE      text                     null comment '资源备注',
    RTYPE      varchar(100) default '1' null comment '资源类型(''显示''：功能页面，''权限''：权限控制，''隐藏''：隐藏功能)',
    UPDATETIME datetime                 not null comment '更新时间',
    RLVL       int                      null comment '资源级别，root：0',
    LEAF       int                      null comment '是否为叶子节点（是：1，否：0）'
)
    comment '系统框架业务资源表';

create table sys_role
(
    ID         varchar(32)  not null comment '角色ID'
        primary key,
    RONAME     varchar(100) null comment '角色名称',
    RONOTE     varchar(200) null comment '角色备注',
    ROSORT     int          null comment '排序',
    UPDATETIME datetime     not null comment '更新时间'
)
    comment '系统框架角色表';

create table sys_role_dept
(
    ID         varchar(32) not null
        primary key,
    RO_ID      varchar(32) not null comment '角色ID',
    D_ID       varchar(32) not null comment '部门ID',
    UPDATETIME datetime    not null comment '更新时间'
)
    comment '系统框架角色与部门关系表（部门数据权限）';

create table sys_role_res
(
    ID         varchar(32) not null
        primary key,
    RO_ID      varchar(32) not null comment '角色ID',
    R_ID       varchar(32) not null comment '资源ID',
    UPDATETIME datetime    not null comment '更新时间'
)
    comment '系统框架角色与业务资源关系表';

create table sys_upfile
(
    ID           varchar(32)  not null
        primary key,
    RELATEDTABLE varchar(50)  null comment '关联表名称',
    RELATEDID    varchar(32)  null comment '关联表记录主键ID',
    RELATEDTYPE  varchar(50)  null comment '关联表类别，用于区分不同模块',
    FILEPATH     varchar(500) null comment '文件路径',
    FILETYPE     varchar(50)  null comment '文件类型',
    FILESIZE     int          null comment '文件大小',
    SORTORDER    int          null comment '排序',
    CATALOGBM    varchar(32)  null comment '目录类别，关联字典表sys_dics主键',
    CATALOGMC    varchar(50)  null comment '目录类别，关联字典表sys_dics名称',
    BZNR         varchar(500) null comment '备注内容',
    JGBM         varchar(32)  null comment '文件所属单位编码（访问权限控制）',
    JGMC         varchar(200) null comment '文件所属单位名称（访问权限控制）',
    DEPTID       varchar(50)  null comment '部门ID',
    DEPTNAME     varchar(100) null comment '部门名称',
    LRRYID       varchar(50)  null comment '录入人员ID',
    LRRYMC       varchar(50)  null comment '录入人员姓名',
    INSERTTIME   datetime     null comment '录入时间',
    UPDATETIME   datetime     null comment '时间戳',
    ISDELETED    varchar(1)   null comment '删除标志（0：不删除，1：删除）'
)
    comment '文件上传信息表';

create table sys_user
(
    ID         varchar(32)  not null comment '用户ID',
    DEPTID     varchar(32)  null comment '部门ID',
    UUSER      varchar(20)  null comment '用户名',
    UPASS      varchar(32)  null comment '密码',
    UNAME      varchar(20)  null comment '姓名',
    USEX       varchar(3)   null comment '性别',
    UEMAIL     varchar(100) null comment 'email',
    UMOBILE    varchar(20)  null comment '手机号',
    UIP        varchar(200) null comment 'IP地址',
    UNOTE      text         null comment '备注',
    UPOSITION  varchar(50)  null comment '岗位',
    ISVALID    varchar(1)   not null comment '是否有效：1:有效, 0:无效',
    UBIRTHDAY  datetime     null comment '出生日期',
    UPDATETIME datetime     not null comment '更新时间',
    QQ         varchar(50)  null comment 'QQ号',
    WX         varchar(200) null comment '微信号',
    WXUSERID   varchar(100) null comment '微信企业号userid，用于发送微信消息',
    WXOPENID   varchar(100) null comment '微信服务号openid，用于发送微信消息',
    ISDELETED  varchar(1)   null comment '删除标示（0：不删除，1：删除）',
    dept_ids   varchar(500) null,
    user_perm  varchar(500) null,
    uniqueId   varchar(255) null comment '手机唯一标识',
    constraint sys_user_id
        unique (ID)
)
    comment '系统框架用户表';

create index ISVALID
    on sys_user (ISVALID, ISDELETED);

create index UMOBILE
    on sys_user (UMOBILE);

alter table sys_user
    add primary key (ID);

create table sys_user_attendance
(
    ID              bigint(32) auto_increment
        primary key,
    USER_ID         varchar(32) null,
    CHECK_TYPE      int(1)      not null comment '签到类型',
    ATTENDANCE_DATE varchar(8)  null,
    ATTENDANCE_TIME varchar(5)  null
);

create table sys_user_dept
(
    ID         varchar(32) not null
        primary key,
    U_ID       varchar(32) not null comment '用户ID',
    D_ID       varchar(32) not null comment '部门ID',
    UPDATETIME datetime    not null comment '更新时间'
)
    comment '系统框架角色与部门关系表（部门数据权限）';

create index U_ID
    on sys_user_dept (U_ID, D_ID);

create table sys_user_extend
(
    USERID     varchar(32)     null comment '用户ID',
    DEPTID     varchar(32)     null comment '用户部门ID',
    DXTS       int             null comment '短信条数(条)',
    DXDJ       decimal(65, 30) null comment '短信单价(分)',
    ISHFF      varchar(10)     null comment '是否为后付费用户(1：是，0：否)',
    ISCHILD    varchar(10)     null comment '是否为子账号(1：是，0：否)',
    SJUSERID   varchar(32)     null comment '当为子账号时他的上级账号ID',
    XZTS       varchar(10)     null comment '当为子账号时，是否限制条数(1：限制，0：不限制），不限制时发送条数为主账号条数',
    UPDATETIME datetime        null comment '更新时间'
);

create table sys_user_role
(
    ID         varchar(32) not null
        primary key,
    U_ID       varchar(32) not null comment '用户ID',
    RO_ID      varchar(32) not null comment '角色ID',
    UPDATETIME datetime    not null comment '更新时间'
)
    comment '系统框架用户与角色关系表';

create table sys_user_schedule
(
    ID              bigint(32) auto_increment
        primary key,
    USER_ID         varchar(32) null,
    FLAG            varchar(1)  not null,
    ATTENDANCE_DATE varchar(8)  null
);

create table t_finance
(
    ID             varchar(32)  not null
        primary key,
    APPROFILETYPE  varchar(255) null,
    BUYMONEY       float        null,
    BUYPROJECTNO   varchar(255) null,
    BUYPROJECTORG  varchar(255) null,
    BUYUSE         varchar(255) null,
    BUYYEAR        varchar(255) null,
    CATEGORY       varchar(255) null,
    COLLECTORG     varchar(255) null,
    EXPENSEACCOUNT varchar(255) null,
    HAPPENYEAR     int          null,
    MONEYAREA      varchar(255) null,
    MONEYSOURCE    varchar(255) null,
    MONEYTOTAL     float        null,
    MONEYUSE       varchar(255) null,
    PAYTIME        datetime     null,
    ZBWNO          varchar(255) null
);

create table t_pk_enterexit
(
    P_Key             bigint(8) unsigned not null
        primary key,
    CLIENTIPADDR      varchar(15)        null comment '客户端IP
',
    ParkNumber        bigint(8)          null comment '停车场编号
',
    CardCode          varchar(16)        null comment '卡内码
',
    CardType          tinyint(1)         null comment '卡类型
',
    PlateNumber       varchar(16)        null comment '车牌号
',
    PlateType         varchar(16)        null comment '车牌类型
',
    VType             tinyint(1)         null comment '车辆类型
',
    CustomerType      tinyint(1)         null comment '客户类型
',
    Visitant          tinyint(1)         null comment '贵宾卡（0-非贵宾卡 1-贵宾卡）
',
    EnterTime         datetime           null comment '入场时间
',
    EnterDeviceNumber bigint(8)          null comment '入场设备编号
',
    EnterDeviceName   varchar(32)        null comment '入场控制器名称
',
    EnterOfficerID    int(4)             null comment '入场操作员ID
',
    EnterOfficerName  varchar(32)        null comment '入场操作员
',
    EnterPhotoFile    varchar(128)       null comment '入场图片文件名称
',
    EnterPhotoLength  int(4)             null comment '入场图片文件长度
',
    ExitTime          datetime           null comment '出场时间
',
    ExitDeviceNumber  bigint(8)          null comment '出场设备编号
',
    ExitDeviceName    varchar(32)        null comment '出场控制器名称
',
    ExitOfficerID     int(4)             null comment '出场操作员ID
',
    ExitOfficerName   varchar(32)        null comment '出场操作员
',
    ExitPhotoFile     varchar(128)       null comment '出场图片文件名称
',
    ExitPhotoLength   int(4)             null comment '出场图片文件长度
',
    FreePhotoFile     varchar(128)       null comment '证件图片文件名称
',
    FreePhotoLength   int(4)             null comment '证件图片文件长度
',
    KeepTime          int(4)             null comment '停车时间
',
    ChargeLevelName   varchar(32)        null comment '收费标准名称
',
    ReceiveMoney      double             null comment '应收款
',
    ChargeType        tinyint(1)         null comment '"收费类型(1-现金 2-银行卡
 3-网络支付)"
',
    SettlementType    tinyint(1)         null comment '网络扣费类型(0-自动 1-手动)
',
    InternetBalance   double             null comment '网络帐户余额
',
    InternetOrder     bigint(8)          null comment '网络订单号
',
    LimitMoney        double             null comment '保底金额
',
    ChargeTime        datetime           null comment '收费时间（网络收费、中央收费）

',
    ChargeOperator    varchar(32)        null comment '收费员
',
    FreeCharge        tinyint(1)         null comment '是否优惠(0-不优惠  1-优惠)
',
    FreeChargeType    tinyint(1)         null comment '"消费优惠方式（1-计时优惠
 2-计费优惠）"
',
    ChargeAddr        varchar(32)        null comment '消费场所
',
    FreeTime          int(4)             null comment '优惠时间(分)
',
    FreeMoney         double             null comment '优惠金额
',
    FactMoney         double             null comment '实收金额
',
    PrepayMoney       double             null comment '预付金额
',
    NowpayMoney       double             null comment '现付金额
',
    SegMoney          double             null comment '结算金额
',
    HandReason        varchar(48)        null comment '手动出场原因
',
    FreeReason        varchar(48)        null comment '免费原因
',
    LockState         tinyint(1)         null comment '是否锁定(0-未锁定  1-锁定)
',
    CardNumber        bigint(8)          null comment '卡号
',
    FreeBeginTime     datetime           null comment '优惠开始时间
',
    FreeEndTime       datetime           null comment '优惠结束时间
',
    LocalPayMoney     double             null comment '本地扣费金额',
    FreeUnitNumber    int                null,
    CredentialsType   int                null comment '凭证类型',
    placeNum          int                null,
    PersonName        varchar(32)        null comment '车主姓名
',
    MobilePhone       varchar(32)        null comment '电话号码
',
    AxisNO            varchar(32)        null comment '车位号
',
    HomeAddress       varchar(32)        null comment '家庭住址
',
    parkName          varchar(32)        null comment '停车场名称
'
)
    comment '进出记录表';

create table t_s_attachment
(
    ID                varchar(32)  not null
        primary key,
    attachmentcontent longblob     null,
    attachmenttitle   varchar(100) null,
    businesskey       varchar(32)  null,
    createdate        datetime     null,
    extend            varchar(32)  null,
    note              longtext     null,
    realpath          varchar(100) null,
    subclassname      longtext     null,
    swfpath           longtext     null,
    BUSENTITYNAME     varchar(100) null,
    INFOTYPEID        varchar(32)  null,
    USERID            varchar(32)  null
);

create table cgform_uploadfiles
(
    CGFORM_FIELD varchar(100) not null,
    CGFORM_ID    varchar(36)  not null,
    CGFORM_NAME  varchar(100) not null,
    id           varchar(32)  not null
        primary key,
    constraint FK_qwig8sn3okhvh4wye8nn8gdeg
        foreign key (id) references t_s_attachment (ID)
);

create table t_finance_files
(
    id        varchar(32) not null
        primary key,
    financeId varchar(32) null,
    constraint FK_28m7vvi0cy5r5keke68b6f7rt
        foreign key (id) references t_s_attachment (ID),
    constraint FK_ij2p74feypwcda4n0n96pyd10
        foreign key (financeId) references t_finance (ID)
);

create index FK_mnq23hlc835n4ufgjl7nkn3bd
    on t_s_attachment (USERID);

create table t_s_demo
(
    ID        varchar(32)  not null
        primary key,
    democode  longtext     null,
    demoorder smallint     null,
    demotitle varchar(200) null,
    demourl   varchar(200) null,
    demopid   varchar(32)  null,
    constraint FK_fni8e3v88wcf2sahhlv57u4nm
        foreign key (demopid) references t_s_demo (ID)
);

create table t_s_depart
(
    ID             varchar(32)  not null
        primary key,
    departname     varchar(100) not null,
    description    longtext     null,
    parentdepartid varchar(32)  null,
    constraint FK_knnm3wb0bembwvm0il7tf6686
        foreign key (parentdepartid) references t_s_depart (ID)
);

create table t_s_base_user
(
    ID           varchar(32)  not null
        primary key,
    activitiSync smallint     null,
    browser      varchar(20)  null,
    password     varchar(100) null,
    realname     varchar(50)  null,
    signature    blob         null,
    status       smallint     null,
    userkey      varchar(200) null,
    username     varchar(10)  not null,
    departid     varchar(32)  null,
    constraint FK_15jh1g4iem1857546ggor42et
        foreign key (departid) references t_s_depart (ID)
);

create table t_s_document
(
    documentstate smallint     null,
    documenttitle varchar(100) null,
    pictureindex  blob         null,
    showhome      smallint     null,
    id            varchar(32)  not null
        primary key,
    typeid        varchar(32)  null
);

create index FK_f2mc12eu0umghp2i70apmtxjl
    on t_s_document (id);

create index FK_qr3qlmgkflj35m5ci1xv0vvg3
    on t_s_document (typeid);

create table t_s_fileno
(
    ID           varchar(32) not null
        primary key,
    filenobefore varchar(32) null,
    filenonum    int         null,
    filenotype   varchar(32) null,
    filenoYear   date        null
);

create table t_s_icon
(
    ID       varchar(32)  not null
        primary key,
    extend   varchar(255) null,
    iconclas varchar(200) null,
    content  blob         null,
    name     varchar(100) not null,
    path     longtext     null,
    type     smallint     null
);

create table t_s_function
(
    ID               varchar(32)  not null
        primary key,
    functioniframe   smallint     null,
    functionlevel    smallint     null,
    functionname     varchar(50)  not null,
    functionorder    varchar(255) null,
    functionurl      varchar(100) null,
    parentfunctionid varchar(32)  null,
    iconid           varchar(32)  null,
    desk_iconid      varchar(32)  null,
    constraint FK_brd7b3keorj8pmxcv8bpahnxp
        foreign key (parentfunctionid) references t_s_function (ID),
    constraint FK_gbdacaoju6d5u53rp4jo4rbs9
        foreign key (desk_iconid) references t_s_icon (ID),
    constraint FK_q5tqo3v4ltsp1pehdxd59rccx
        foreign key (iconid) references t_s_icon (ID)
);

create table t_s_operation
(
    ID            varchar(32)  not null
        primary key,
    operationcode varchar(50)  null,
    operationicon varchar(100) null,
    operationname varchar(50)  null,
    status        smallint     null,
    functionid    varchar(32)  null,
    iconid        varchar(32)  null,
    constraint FK_ny5de7922l39ta2pkhyspd5f
        foreign key (iconid) references t_s_icon (ID),
    constraint FK_pceuy41wr2fjbcilyc7mk3m1f
        foreign key (functionid) references t_s_function (ID)
);

create table t_s_opintemplate
(
    ID       varchar(32)  not null
        primary key,
    descript varchar(100) null
);

create table t_s_role
(
    ID       varchar(32)  not null
        primary key,
    rolecode varchar(10)  null,
    rolename varchar(100) not null
);

create table t_s_role_function
(
    ID         varchar(32)  not null
        primary key,
    operation  varchar(100) null,
    functionid varchar(32)  null,
    roleid     varchar(32)  null,
    constraint FK_9dww3p4w8jwvlrgwhpitsbfif
        foreign key (roleid) references t_s_role (ID),
    constraint FK_fvsillj2cxyk5thnuu625urab
        foreign key (functionid) references t_s_function (ID)
);

create table t_s_student
(
    ID        varchar(32)  not null
        primary key,
    classname varchar(255) null,
    name      varchar(255) null,
    sex       varchar(255) null
);

create table t_s_territory
(
    ID                varchar(32) not null
        primary key,
    territorycode     varchar(10) not null,
    territorylevel    smallint    not null,
    territoryname     varchar(50) not null,
    territory_pinyin  varchar(40) null,
    territorysort     varchar(3)  not null,
    x_wgs84           double      not null,
    y_wgs84           double      not null,
    territoryparentid varchar(32) null
);

create table t_s_timetask
(
    ID              varchar(32)  not null
        primary key,
    CREATE_BY       varchar(32)  null,
    CREATE_DATE     datetime     null,
    CREATE_NAME     varchar(32)  null,
    CRON_EXPRESSION varchar(100) not null,
    IS_EFFECT       varchar(1)   not null,
    IS_START        varchar(1)   not null,
    TASK_DESCRIBE   varchar(50)  not null,
    TASK_ID         varchar(100) not null,
    UPDATE_BY       varchar(32)  null,
    UPDATE_DATE     datetime     null,
    UPDATE_NAME     varchar(32)  null
);

create table t_s_typegroup
(
    ID            varchar(32) not null
        primary key,
    typegroupcode varchar(50) null,
    typegroupname varchar(50) null
);

create table t_s_type
(
    ID          varchar(32) not null
        primary key,
    typecode    varchar(50) null,
    typename    varchar(50) null,
    typepid     varchar(32) null,
    typegroupid varchar(32) null,
    constraint FK_3q40mr4ebtd0cvx79matl39x1
        foreign key (typegroupid) references t_s_typegroup (ID),
    constraint FK_nw2b22gy7plh7pqows186odmq
        foreign key (typepid) references t_s_type (ID)
);

create table t_s_user
(
    email         varchar(50)            null,
    mobilePhone   varchar(30)            null,
    officePhone   varchar(20)            null,
    signatureFile varchar(100)           null,
    id            varchar(32)            not null
        primary key,
    accountid     varchar(36)            null,
    type          varchar(2) default '1' null,
    constraint FK_2cuji5h6yorrxgsr8ojndlmal
        foreign key (id) references t_s_base_user (ID)
);

create table t_s_config
(
    ID      varchar(32)  not null
        primary key,
    code    varchar(100) null,
    content longtext     null,
    name    varchar(100) not null,
    note    longtext     null,
    userid  varchar(32)  null,
    constraint FK_m3q8r50ror4fl7fjkvd82tqgn
        foreign key (userid) references t_s_user (id)
);

create table t_s_log
(
    ID          varchar(32)  not null
        primary key,
    broswer     varchar(100) null,
    logcontent  longtext     not null,
    loglevel    smallint     null,
    note        longtext     null,
    operatetime datetime     not null,
    operatetype smallint     null,
    userid      varchar(32)  null,
    constraint FK_oe64k4852uylhyc5a00rfwtay
        foreign key (userid) references t_s_user (id)
);

create table t_s_role_user
(
    ID     varchar(32) not null
        primary key,
    roleid varchar(32) null,
    userid varchar(32) null,
    constraint FK_d4qb5xld2pfb0bkjx9iwtolda
        foreign key (userid) references t_s_user (id),
    constraint FK_n2ucxeorvpjy7qhnmuem01kbx
        foreign key (roleid) references t_s_role (ID)
);

create table t_s_version
(
    ID          varchar(32)  not null
        primary key,
    loginpage   varchar(100) null,
    versioncode varchar(50)  null,
    versionname varchar(30)  null,
    versionnum  varchar(20)  null
);

create table udesk_project_relation
(
    id            bigint unsigned auto_increment
        primary key,
    assignee_id   int(11) unsigned              null comment '受理客服id',
    assignee_name varchar(50)                   null comment '受理客服姓名',
    dept_id       varchar(50)                   null comment '对应部门主键',
    dept_code     varchar(50)                   null comment '对应部门编码',
    dept_name     varchar(50)                   null comment '对应部门名称',
    status        tinyint(1) unsigned default 1 null comment '记录状态'
)
    comment 'udesk客服系统客服部门对应关系';

create index idx_assignee_project
    on udesk_project_relation (assignee_id, dept_id);

create table weixin_accesstoken
(
    ID           varchar(32)  not null
        primary key,
    access_token varchar(255) null,
    addtime      datetime     null,
    expires_ib   int          null
);

create table weixin_account
(
    id                 varchar(36)   not null comment '主键'
        primary key,
    accountname        varchar(200)  null comment '公众帐号名称',
    accounttoken       varchar(200)  null comment '公众帐号TOKEN',
    accountnumber      varchar(200)  null comment '公众微信号',
    accounttype        varchar(50)   null comment '公众号类型',
    accountemail       varchar(200)  null comment '电子邮箱',
    accountdesc        varchar(500)  null comment '公众帐号描述',
    accountaccesstoken varchar(1000) null comment 'ACCESS_TOKEN',
    accountappid       varchar(200)  null comment '公众帐号APPID',
    accountappsecret   varchar(500)  null comment '公众帐号APPSECRET',
    ADDTOEKNTIME       datetime      null,
    USERNAME           varchar(50)   null,
    WEIXIN_ACCOUNTID   varchar(100)  null,
    apiticket          varchar(200)  null,
    apiticketttime     datetime      null,
    jsapiticket        varchar(200)  null,
    jsapitickettime    datetime      null
);

create table weixin_autoresponse
(
    ID           varchar(32)  not null
        primary key,
    addtime      varchar(255) null,
    keyword      varchar(255) null,
    msgtype      varchar(255) null,
    rescontent   varchar(255) null,
    templatename varchar(255) null,
    accountid    varchar(100) null
);

create table weixin_cms_ad
(
    ID          varchar(36)  not null
        primary key,
    ACCOUNTID   varchar(100) null,
    CREATE_BY   varchar(255) null,
    CREATE_DATE datetime     null,
    CREATE_NAME varchar(255) null,
    IMAGE_HREF  varchar(255) null,
    IMAGE_NAME  varchar(255) null,
    TITLE       varchar(20)  null
);

create table weixin_cms_article
(
    id          varchar(36)    not null comment '主键'
        primary key,
    title       varchar(50)    null comment '标题',
    image_name  varchar(255)   null comment '图片名称',
    image_href  varchar(255)   null comment '图片地址',
    summary     varchar(255)   null,
    content     varchar(20000) null comment '内容',
    column_id   varchar(36)    null comment '栏目id',
    accountid   varchar(100)   null comment '微信账户',
    create_name varchar(255)   null comment '创建人',
    create_by   varchar(255)   null comment '创建人id',
    create_date datetime       null comment '创建日期'
);

create table weixin_cms_menu
(
    ID          varchar(36)  not null
        primary key,
    ACCOUNTID   varchar(100) null,
    CREATE_BY   varchar(255) null,
    CREATE_DATE datetime     null,
    CREATE_NAME varchar(255) null,
    IMAGE_HREF  varchar(255) null,
    IMAGE_NAME  varchar(255) null,
    NAME        varchar(20)  null,
    TYPE        varchar(20)  null comment '类型'
);

create table weixin_cms_site
(
    ID                  varchar(36)  not null
        primary key,
    ACCOUNTID           varchar(32)  null,
    COMPANY_TEL         varchar(50)  null,
    CREATE_DATE         datetime     null,
    CREATE_NAME         varchar(50)  null,
    SITE_LOGO           varchar(200) null,
    SITE_NAME           varchar(100) null,
    SITE_TEMPLATE_STYLE varchar(50)  null,
    UPDATE_DATE         datetime     null,
    UPDATE_NAME         varchar(50)  null
);

create table weixin_cms_style
(
    ID             varchar(36)  not null
        primary key,
    ACCOUNTID      varchar(50)  null,
    CREATE_DATE    datetime     null,
    CREATE_NAME    varchar(50)  null,
    REVIEW_IMG_URL varchar(100) null,
    TEMPLATE_NAME  varchar(100) null,
    TEMPLATE_URL   varchar(200) null,
    UPDATE_DATE    datetime     null,
    UPDATE_NAME    varchar(50)  null
);

create table weixin_expandconfig
(
    ID        varchar(36)  not null
        primary key,
    ACCOUNTID varchar(200) null,
    CLASSNAME varchar(100) not null,
    CONTENT   longtext     null,
    KEYWORD   varchar(100) not null,
    NAME      varchar(100) null
);

create table weixin_hdrecord
(
    ID        varchar(100) not null
        primary key,
    ADDTIME   datetime     null,
    HDID      varchar(100) null,
    NICKNAME  varchar(200) null,
    OPENDID   varchar(100) null,
    TOTAL     int          null,
    accountid varchar(100) null
);

create table weixin_huodong
(
    id          varchar(100) not null comment '键主'
        primary key,
    title       varchar(400) null comment '活动名称',
    description text         null comment '活动描述',
    priceone    varchar(400) null comment '一等奖奖品',
    onetotal    int(4)       null comment '一等奖数量',
    pricetwo    varchar(400) null comment '二等奖奖品',
    twototal    int(4)       null comment '二等奖数量',
    pricethree  varchar(400) null comment '三等奖奖品',
    threetotal  int(4)       null comment '三等奖数量',
    starttime   timestamp    null comment '开始时间',
    endtime     timestamp    null on update CURRENT_TIMESTAMP comment '结束时间',
    type        varchar(100) null comment '活动类型',
    gl          varchar(100) null,
    count       varchar(10)  null,
    accountid   varchar(100) null
);

create table weixin_linksucai
(
    id            varchar(36)             not null
        primary key,
    create_name   varchar(50)             null comment '创建人名称',
    create_date   datetime                null comment '创建日期',
    update_name   varchar(50)             null comment '修改人名称',
    update_date   datetime                null comment '修改日期',
    name          varchar(100)            null comment '链接名称',
    outer_link    longtext                null comment '外部链接',
    content       longtext                null comment '功能描述',
    inner_link    longtext                null comment '内部链接',
    transfer_sign int                     null comment '转换标志',
    accountid     varchar(100)            null comment '微信账户id',
    post_code     varchar(200)            null comment '账号邮编',
    share_status  varchar(10) default 'N' null comment '分享状态',
    is_encrypt    int(2)      default 0   null comment '是否加密（0：不加密，1：加密）'
);

create table weixin_menuentity
(
    ID         varchar(32)  not null
        primary key,
    menukey    varchar(255) null,
    msgtype    varchar(255) null,
    name       varchar(255) null,
    orders     varchar(11)  null,
    templateid varchar(255) null,
    type       varchar(255) null,
    url        varchar(255) null,
    fatherid   varchar(32)  null,
    accountid  varchar(255) null
);

create index FK_astulwpsla864at9igbas3eic
    on weixin_menuentity (fatherid);

create table weixin_newstemplate
(
    ID          varchar(32)  not null
        primary key,
    addtime     varchar(255) null,
    tempatename varchar(255) null,
    type        varchar(255) null,
    accountid   varchar(100) null
);

create table weixin_newsitem
(
    ID          varchar(32)  not null
        primary key,
    new_type    varchar(255) null comment '图文类型：图文还是外部url',
    author      varchar(255) null,
    content     text         null,
    description varchar(255) null,
    imagepath   varchar(255) null,
    orders      varchar(255) null,
    title       varchar(255) null,
    templateid  varchar(32)  null,
    url         varchar(255) null comment '外部URL',
    create_date date         null,
    accountid   varchar(100) null,
    constraint FK_m8qs8ufeqkk5cx17budto66r0
        foreign key (templateid) references weixin_newstemplate (ID)
);

create table weixin_open_account
(
    id              varchar(36)  not null comment '主键'
        primary key,
    appid           varchar(200) null,
    ticket          varchar(200) null comment '第三方平台推送 : ticket',
    get_ticket_time datetime     null
);

create table weixin_photo
(
    ID             varchar(32)  not null
        primary key,
    PHOTO_ALBUM_ID varchar(32)  null comment '对应相册',
    CONTENT        varchar(255) null comment '相片描述',
    CREATE_BY      varchar(32)  null,
    CREATE_DATE    datetime     null,
    NAME           varchar(100) null comment '相片名字',
    UPDATE_BY      varchar(32)  null,
    UPDATE_DATE    datetime     null
);

create table weixin_photo_album
(
    ID          varchar(32)  not null
        primary key,
    NAME        varchar(100) null comment '相册名称',
    CONTENT     varchar(255) null comment '相册描述',
    ACCOUNTID   varchar(100) null,
    CREATE_DATE datetime     null comment '创建时间',
    CREATE_BY   varchar(32)  null comment '创建人',
    UPDATE_DATE datetime     null comment '修改时间',
    UPDATE_BY   varchar(32)  null comment '修改人',
    PHOTO_ID    varchar(32)  null comment '封面相片'
);

create table weixin_prizerecord
(
    ID        varchar(100) not null
        primary key,
    ADDTIME   datetime     null,
    HDID      varchar(100) null,
    MOBILE    varchar(100) null,
    openid    varchar(255) null,
    PRIZE     varchar(100) null,
    accountid varchar(100) null
);

create table weixin_receivetext
(
    ID           varchar(32)  not null
        primary key,
    content      varchar(255) null,
    createtime   datetime     null,
    fromusername varchar(255) null,
    msgid        varchar(255) null,
    msgtype      varchar(255) null,
    rescontent   varchar(255) null,
    response     varchar(255) null,
    tousername   varchar(255) null,
    accountid    varchar(100) null,
    nickname     varchar(200) null
);

create table weixin_subscribe
(
    ID           varchar(32) charset utf8  not null
        primary key,
    accountid    varchar(255) charset utf8 null,
    addTime      varchar(255) charset utf8 null,
    msgType      varchar(255) charset utf8 null,
    templateId   varchar(255) charset utf8 null,
    templateName varchar(255) charset utf8 null
)
    charset = latin1;

create table weixin_texttemplate
(
    ID           varchar(32)  not null
        primary key,
    addtime      varchar(255) null,
    content      varchar(255) null,
    templatename varchar(255) null,
    accountid    varchar(100) null
);

create table wywx_areazone
(
    province int          null,
    city     int          null,
    zone     int          null,
    areazone varchar(255) null
)
    charset = utf8mb4;

create table wywx_bjfx
(
    id              varchar(32)                            not null comment '主键'
        primary key,
    code            varchar(50)                            null comment '搬家放行单编号',
    address         varchar(50)                            null comment '房号',
    ownername       varchar(50)                            null comment '业主姓名',
    concatphone     varchar(50)                            null comment '联系电话',
    bjrq            date                                   null comment '搬家日期',
    wpms            varchar(200)                           null comment '大件物品描述',
    bjclsl          varchar(50)                            null comment '预计搬家车辆数量',
    dispatchmanid   varchar(50)                            null comment '审核人员（管家）人员ID（wywx_serviceman表servicewxid，type=1）微信openid',
    dispatchman     varchar(50)                            null comment '审核人员（管家）姓名',
    dispatchphone   varchar(50)                            null comment '审核人员（管家）电话',
    dispatchcomment varchar(500)                           null comment '审核备注（管家审核处理时输入文本描述说明，语音描述作为附件存在wywx_file_attachment表）',
    dispatchtime    datetime                               null comment '审核时间',
    repairmanid     varchar(32)                            null comment '确认放行员工ID（wywx_serviceman表servicewxid，type=3）微信openid',
    repairman       varchar(50)                            null comment '确认放行人员姓名',
    repairmanphone  varchar(50)                            null comment '确认放行人员电话',
    repairedtime    datetime                               null comment '确认放行时间',
    status          varchar(1)                             null comment '状态标识（0：等待审核，1：审核通过，2：审核不通过，3：确认放行）',
    lrryid          varchar(50)                            null comment '录入人员ID',
    lrrymc          varchar(50)                            null comment '录入人员姓名',
    openid          varchar(200)                           null comment '微信端申请人员openid',
    nickname        varchar(100)                           null comment '微信端申请人员的昵称',
    imageurl        varchar(300)                           null comment '微信端申请人员头像',
    inserttime      datetime                               null comment '录入时间',
    updatetime      datetime                               null comment '时间戳',
    isdeleted       varchar(1)                             null comment '删除标志（0：不删除，1：删除）',
    deptid          varchar(50)                            null comment '部门id',
    deptname        varchar(50)                            null comment '部门名称',
    gdtb            varchar(1) charset utf8mb4 default '0' null comment '工单同步标示（0：未同步，1：同步成功，2：同步出错）',
    gdno            varchar(50) charset utf8mb4            null comment '工单系统返回工单编号',
    gderr           varchar(500) charset utf8mb4           null comment '工单系统返回错误消息'
)
    comment '搬家放行信息表';

create table wywx_bjfxclry
(
    ID         varchar(32) not null
        primary key,
    name       varchar(50) null comment '姓名',
    wxid       varchar(50) null comment '微信服务号OpenID，用于发送微信消息使用',
    wxuserid   varchar(50) null comment '微信企业号UserID，用于发送微信消息使用',
    phone      varchar(50) null comment '手机号',
    type       varchar(10) null comment '处理人员类别（1：管家，3：保安）',
    lrryid     varchar(50) null comment '录入人员ID',
    lrrymc     varchar(50) null comment '录入人员姓名',
    inserttime datetime    null comment '录入时间',
    deptid     varchar(50) null comment '部门id',
    deptname   varchar(50) null comment '部门名称'
)
    comment '报修处理人员信息表
业主报修后，接收报修微信提醒人员列表';

create table wywx_bxclry
(
    id         varchar(32) not null
        primary key,
    name       varchar(50) null comment '姓名',
    wxid       varchar(50) null comment '微信服务号OpenID，用于发送微信消息使用',
    wxuserid   varchar(50) null comment '微信企业号UserID，用于发送微信消息使用',
    phone      varchar(50) null comment '手机号',
    lrryid     varchar(50) null comment '录入人员ID',
    lrrymc     varchar(50) null comment '录入人员姓名',
    inserttime datetime    null comment '录入时间',
    deptid     varchar(50) null comment '部门id',
    deptname   varchar(50) null comment '部门名称'
)
    comment '报修处理人员信息表
业主报修后，接收报修微信提醒人员列表';

create table wywx_cbscorp
(
    id         varchar(32) not null,
    cbsid      varchar(50) not null comment '承建商主键',
    pk_corp    varchar(50) not null comment '项目主键',
    lrryid     varchar(50) null comment '录入人员ID',
    lrrymc     varchar(50) null comment '录入人员姓名',
    inserttime datetime    null comment '录入时间',
    deptid     varchar(50) null comment '部门id',
    deptname   varchar(50) null comment '部门名称',
    primary key (cbsid, pk_corp),
    constraint wywx_cbscorp_id
        unique (id)
);

create index wywx_cbscorp_cbsid
    on wywx_cbscorp (cbsid);

create index wywx_cbscorp_pk_corp
    on wywx_cbscorp (pk_corp);

create table wywx_cbsxx
(
    id         varchar(32)  not null,
    cjsjc      varchar(255) null comment '承建商简称',
    cjsqc      varchar(255) null comment '承建商全称',
    fzr        varchar(255) null comment '负责人',
    lxr        varchar(255) null comment '联系人',
    lxdh       varchar(255) null comment '联系电话',
    lrryid     varchar(50)  null comment '录入人员ID',
    lrrymc     varchar(50)  null comment '录入人员姓名',
    inserttime datetime     null comment '录入时间',
    updatetime datetime     null comment '时间戳',
    deptid     varchar(50)  null comment '部门id',
    deptname   varchar(50)  null comment '部门名称',
    isdeleted  varchar(255) null comment '删除标志（0：不删除，1：删除）',
    constraint wywx_cbsxx_id_pk
        unique (id)
)
    comment '承建商信息列表';

create index wywx_cbsxx_cjsjc
    on wywx_cbsxx (cjsjc);

create index wywx_cbsxx_cjsqc
    on wywx_cbsxx (cjsqc);

alter table wywx_cbsxx
    add primary key (id);

create table wywx_complaint
(
    id            varchar(32) charset utf8  not null comment '主键'
        primary key,
    ownername     varchar(50) charset utf8  null comment '联系人',
    concatphone   varchar(50) charset utf8  null comment '联系电话',
    dics_id       varchar(32) charset utf8  null comment '投诉建议类型pk',
    dics_name     varchar(50) charset utf8  null comment '投诉建议类型名称',
    complaintinfo varchar(500) charset utf8 null comment '投诉建议描述信息',
    status        varchar(1) charset utf8   null comment '状态标识（0：开始处理，1：完成）',
    isdeleted     varchar(1) charset utf8   null comment '删除标志（0：不删除，1：删除）',
    updatetime    datetime                  null comment '时间戳',
    inserttime    datetime                  null comment '录入时间',
    lrryid        varchar(50) charset utf8  not null comment '录入人员ID',
    lrrymc        varchar(50) charset utf8  null comment '录入人员姓名',
    openid        varchar(200) charset utf8 null comment '微信端人员openid',
    nickname      varchar(100) charset utf8 null comment '微信端人员的昵称',
    imageurl      varchar(300) charset utf8 null comment '微信端人员头像'
)
    comment '投诉建议信息表' charset = utf8mb4;

create table wywx_cssj_msg_log
(
    id             varchar(32) charset utf8mb4  not null comment '主键'
        primary key,
    name           varchar(50)                  null comment '接收人员姓名',
    phone          varchar(32) charset utf8mb4  null comment '手机号',
    wxuserid       varchar(50) charset utf8mb4  null comment '企业号userid',
    gdid           varchar(50) charset utf8mb4  null comment '工单ID',
    msg            varchar(200) charset utf8mb4 null comment '消息内容',
    cssjflag       varchar(2)                   null comment '级别（1：项目级，2：区域级，3：总部级）',
    sendstatus     varchar(10) charset utf8mb4  null comment '发送短信是否成功（0：未发送，3：不发送，1：成功，2：失败）',
    sendtime       datetime                     null comment '发送短信时间',
    sendstatus_qyh varchar(10)                  null comment '发送企业号消息是否成功（0：未发送，3：不发送，1：成功，2：失败）',
    sendtime_qyh   datetime                     null comment '发送企业号时间',
    inserttime     datetime                     null comment '录入时间'
);

create index wywx_cssj_msg_log_1
    on wywx_cssj_msg_log (cssjflag);

create index wywx_cssj_msg_log_2
    on wywx_cssj_msg_log (gdid);

create index wywx_cssj_msg_log_3
    on wywx_cssj_msg_log (inserttime);

create table wywx_dbzrry
(
    ID         varchar(32) not null,
    name       varchar(50) null comment '姓名',
    wxid       varchar(50) null comment '微信服务号OpenID，用于发送微信消息使用',
    wxuserid   varchar(50) null comment '微信企业号UserID，用于发送微信消息使用',
    phone      varchar(50) null comment '手机号',
    lrryid     varchar(50) null comment '录入人员ID',
    lrrymc     varchar(50) null comment '录入人员姓名',
    inserttime datetime    null comment '录入时间',
    deptid     varchar(50) null comment '部门id',
    deptname   varchar(50) null comment '部门名称'
)
    comment '督办责任人配置';

create table wywx_fault_repair
(
    id                varchar(32) charset utf8  not null comment '主键',
    faultcode         varchar(50) charset utf8  null comment '报修编号',
    address           varchar(200) charset utf8 null comment '用户地址',
    ownername         varchar(50) charset utf8  null comment '业主姓名',
    concatphone       varchar(50) charset utf8  null comment '联系电话',
    dics_id           varchar(32) charset utf8  null comment '报修类型pk(报修1级分类)(服务大类)',
    dics_id2          varchar(32) charset utf8  null comment '报修类型pk(报修2级分类)(服务类型)',
    dics_id3          varchar(32) charset utf8  null comment '报修类型pk(报修3级分类)(具体类别)',
    dics_id4          varchar(32)               null,
    dics_code         varchar(32) charset utf8  null comment '报修类型编码(报修1级分类)(服务大类)',
    dics_code2        varchar(32) charset utf8  null comment '报修类型编码(报修2级分类)(服务类型)',
    dics_code3        varchar(32) charset utf8  null comment '报修类型编码(报修3级分类)(具体类别)',
    dics_code4        varchar(32)               null,
    dics_name         varchar(50) charset utf8  null comment '报修类型名称(报修1级分类)(服务大类)',
    dics_name2        varchar(50) charset utf8  null comment '报修类型名称(报修2级分类)(服务类型)',
    dics_name3        varchar(50) charset utf8  null comment '报修类型名称(报修3级分类)(类别)',
    dics_name4        varchar(50)               null,
    faultinfo         varchar(500) charset utf8 null comment '报修描述信息',
    dispatchmanid     varchar(50) charset utf8  null comment '派工人员（管家）人员ID（wywx_serviceman表servicewxid，type=1）微信openid',
    dispatchman       varchar(50) charset utf8  null comment '派工人员（管家）姓名',
    dispatchphone     varchar(50) charset utf8  null comment '派工人员（管家）电话',
    dispatchcomment   varchar(500) charset utf8 null comment '派工备注（管家派工处理时输入文本报修描述说明，语音描述作为附件存在wywx_file_attachment表）',
    dispatchtime      datetime                  null comment '派工时间',
    repairmanid       varchar(32) charset utf8  null comment '维修（员工）人员ID（wywx_serviceman表servicewxid，type=2）微信openid',
    repairman         varchar(50) charset utf8  null comment '维修人员姓名',
    repairmanphone    varchar(50) charset utf8  null comment '维修人员电话',
    repairedtime      datetime                  null comment '维修完成时间',
    repaircomment     varchar(500)              null comment '维修完成备注（派工给员工处理时输入文本，语音描述作为附件存在wywx_file_attachment表）',
    comment           varchar(500) charset utf8 null comment '评价意见',
    commenttime       datetime                  null comment '评价时间',
    evaluate_respons  varchar(2) charset utf8   null comment '评价-响应速度（1-5）星',
    evaluate_service  varchar(2) charset utf8   null comment '评价-服务态度（1-5）星',
    evaluate_result   varchar(2) charset utf8   null comment '评价-处理结果（1-5）星',
    evaluate_all      varchar(2)                null comment '评价分数（5星，有半星情况，值：1-10）',
    status            varchar(2) charset utf8   null comment '//状态标识（0：待派工，1：已派工，2：完成维修，3：完成评价，6：物业管家同意，7：物业管家拒绝，8：已放行，10：暂不处理，11：非正常关闭）（6、7、8属于放行条）',
    type              varchar(10) charset utf8  null comment '类别（1：报修，2：一键报管家，3：投诉，4：建议，5：搬家放行）',
    source            varchar(50)               null comment '工单来源（fwh：服务号，qyh：企业号，jk：接口，web：后台系统）',
    sub_tel           varchar(50)               null comment 'app接口提交工单时提交人手机号',
    lrryid            varchar(50) charset utf8  null comment '录入人员ID',
    lrrymc            varchar(50) charset utf8  null comment '录入人员姓名',
    openid            varchar(200) charset utf8 null comment '微信端报修人员openid',
    nickname          varchar(100) charset utf8 null comment '微信端报修人员的昵称',
    imageurl          varchar(300) charset utf8 null comment '微信端报修人员头像',
    inserttime        datetime                  null comment '录入时间',
    updatetime        datetime                  null comment '时间戳',
    isdeleted         varchar(1) charset utf8   null comment '删除标志（0：不删除，1：删除）',
    deptid            varchar(50) charset utf8  null comment '部门id',
    deptname          varchar(50) charset utf8  null comment '部门名称',
    gdtb              varchar(1) default '0'    null comment '工单同步标示（0：未同步，1：同步成功，2：同步出错）',
    gdno              varchar(50)               null comment '工单系统返回工单编号',
    gderr             varchar(500)              null comment '工单系统返回错误消息',
    pk_equipment      varchar(50)               null comment '设备ID',
    isowner           varchar(50)               null comment '是否业主工单(1:是，0：否）',
    wxdw              varchar(255)              null comment '维修单位',
    zrdw              varchar(255)              null comment '责任单位',
    wxnrfa            varchar(2000)             null comment '维修内容及方案',
    jdry              varchar(50)               null comment '接单人员',
    gdwcsj            datetime                  null comment '规定完成时间',
    cssjflag          varchar(10)               null comment '派单超时时间标识（1：项目级，2：区域级，3：总部级）',
    csbz              varchar(500)              null comment '超时备注',
    yzxx_pk_owner     varchar(50)               null comment '业主主键',
    yzxx_pk_housetype varchar(50)               null comment '楼栋主键',
    yzxx_pk_house     varchar(50)               null comment '房产主键',
    yzxx_pk_corp      varchar(50)               null comment '小区主键',
    indoor            varchar(10)               null comment '室内（1：是，0：否）用于判断保修工单，室内的保修工单',
    pjbqnr            varchar(300)              null comment '评价标签内容',
    gdcsflag          varchar(10)               null comment '关单超时时间标识（1：项目级，2：区域级，3：总部级）',
    gbyysm            varchar(500)              null comment '暂不处理及非正常关闭状态需增加原因说明文本框',
    udesk_ticket_id   int unsigned              null comment 'udesk平台工单Id',
    udesk_record_url  varchar(500)              null comment 'udesk平台通话记录url',
    satisfy_degree    varchar(1)                null comment '满意度（1：是，0：否）',
    constraint wywx_fault_repair_id
        unique (id)
)
    comment '用户报修信息表' engine = MyISAM
                      charset = utf8mb4;

create index wywx_fault_repair_concatphone
    on wywx_fault_repair (concatphone);

create index wywx_fault_repair_cssjflag
    on wywx_fault_repair (cssjflag);

create index wywx_fault_repair_deptid
    on wywx_fault_repair (deptid);

create index wywx_fault_repair_deptname
    on wywx_fault_repair (deptname);

create index wywx_fault_repair_dics_id
    on wywx_fault_repair (dics_id);

create index wywx_fault_repair_dics_id4
    on wywx_fault_repair (dics_id4);

create index wywx_fault_repair_dispatchmanid
    on wywx_fault_repair (dispatchmanid);

create index wywx_fault_repair_dispatchphone
    on wywx_fault_repair (dispatchphone);

create index wywx_fault_repair_faultcode
    on wywx_fault_repair (faultcode);

create index wywx_fault_repair_gdcsflag
    on wywx_fault_repair (gdcsflag);

create index wywx_fault_repair_indoor
    on wywx_fault_repair (indoor);

create index wywx_fault_repair_inserttime
    on wywx_fault_repair (inserttime);

create index wywx_fault_repair_isdeleted
    on wywx_fault_repair (isdeleted);

create index wywx_fault_repair_openid
    on wywx_fault_repair (openid);

create index wywx_fault_repair_pk_equipment
    on wywx_fault_repair (pk_equipment);

create index wywx_fault_repair_repairmanid
    on wywx_fault_repair (repairmanid);

create index wywx_fault_repair_repairmanphone
    on wywx_fault_repair (repairmanphone);

create index wywx_fault_repair_source
    on wywx_fault_repair (source);

create index wywx_fault_repair_status
    on wywx_fault_repair (status);

create index wywx_fault_repair_sub_tel
    on wywx_fault_repair (sub_tel);

create index wywx_fault_repair_type
    on wywx_fault_repair (type);

alter table wywx_fault_repair
    add primary key (id);

create table wywx_fault_repair_2016
(
    id                varchar(32) charset utf8  not null comment '主键',
    faultcode         varchar(50) charset utf8  null comment '报修编号',
    address           varchar(200) charset utf8 null comment '用户地址',
    ownername         varchar(50) charset utf8  null comment '业主姓名',
    concatphone       varchar(50) charset utf8  null comment '联系电话',
    dics_id           varchar(32) charset utf8  null comment '报修类型pk(报修1级分类)(服务大类)',
    dics_id2          varchar(32) charset utf8  null comment '报修类型pk(报修2级分类)(服务类型)',
    dics_id3          varchar(32) charset utf8  null comment '报修类型pk(报修3级分类)(具体类别)',
    dics_id4          varchar(32)               null,
    dics_code         varchar(32) charset utf8  null comment '报修类型编码(报修1级分类)(服务大类)',
    dics_code2        varchar(32) charset utf8  null comment '报修类型编码(报修2级分类)(服务类型)',
    dics_code3        varchar(32) charset utf8  null comment '报修类型编码(报修3级分类)(具体类别)',
    dics_code4        varchar(32)               null,
    dics_name         varchar(50) charset utf8  null comment '报修类型名称(报修1级分类)(服务大类)',
    dics_name2        varchar(50) charset utf8  null comment '报修类型名称(报修2级分类)(服务类型)',
    dics_name3        varchar(50) charset utf8  null comment '报修类型名称(报修3级分类)(类别)',
    dics_name4        varchar(50)               null,
    faultinfo         varchar(500) charset utf8 null comment '报修描述信息',
    dispatchmanid     varchar(50) charset utf8  null comment '派工人员（管家）人员ID（wywx_serviceman表servicewxid，type=1）微信openid',
    dispatchman       varchar(50) charset utf8  null comment '派工人员（管家）姓名',
    dispatchphone     varchar(50) charset utf8  null comment '派工人员（管家）电话',
    dispatchcomment   varchar(500) charset utf8 null comment '派工备注（管家派工处理时输入文本报修描述说明，语音描述作为附件存在wywx_file_attachment表）',
    dispatchtime      datetime                  null comment '派工时间',
    repairmanid       varchar(32) charset utf8  null comment '维修（员工）人员ID（wywx_serviceman表servicewxid，type=2）微信openid',
    repairman         varchar(50) charset utf8  null comment '维修人员姓名',
    repairmanphone    varchar(50) charset utf8  null comment '维修人员电话',
    repairedtime      datetime                  null comment '维修完成时间',
    repaircomment     varchar(500)              null comment '维修完成备注（派工给员工处理时输入文本，语音描述作为附件存在wywx_file_attachment表）',
    comment           varchar(500) charset utf8 null comment '评价意见',
    commenttime       datetime                  null comment '评价时间',
    evaluate_respons  varchar(2) charset utf8   null comment '评价-响应速度（1-5）星',
    evaluate_service  varchar(2) charset utf8   null comment '评价-服务态度（1-5）星',
    evaluate_result   varchar(2) charset utf8   null comment '评价-处理结果（1-5）星',
    evaluate_all      varchar(2)                null comment '评价分数（5星，有半星情况，值：1-10）',
    status            varchar(2) charset utf8   null comment '//状态标识（0：待派工，1：已派工，2：完成维修，3：完成评价，6：物业管家同意，7：物业管家拒绝，8：已放行，10：暂不处理，11：非正常关闭）（6、7、8属于放行条）',
    type              varchar(10) charset utf8  null comment '类别（1：报修，2：一键报管家，3：投诉，4：建议，5：搬家放行）',
    source            varchar(50)               null comment '工单来源（fwh：服务号，qyh：企业号，jk：接口，web：后台系统）',
    sub_tel           varchar(50)               null comment 'app接口提交工单时提交人手机号',
    lrryid            varchar(50) charset utf8  null comment '录入人员ID',
    lrrymc            varchar(50) charset utf8  null comment '录入人员姓名',
    openid            varchar(200) charset utf8 null comment '微信端报修人员openid',
    nickname          varchar(100) charset utf8 null comment '微信端报修人员的昵称',
    imageurl          varchar(300) charset utf8 null comment '微信端报修人员头像',
    inserttime        datetime                  null comment '录入时间',
    updatetime        datetime                  null comment '时间戳',
    isdeleted         varchar(1) charset utf8   null comment '删除标志（0：不删除，1：删除）',
    deptid            varchar(50) charset utf8  null comment '部门id',
    deptname          varchar(50) charset utf8  null comment '部门名称',
    gdtb              varchar(1) default '0'    null comment '工单同步标示（0：未同步，1：同步成功，2：同步出错）',
    gdno              varchar(50)               null comment '工单系统返回工单编号',
    gderr             varchar(500)              null comment '工单系统返回错误消息',
    pk_equipment      varchar(50)               null comment '设备ID',
    isowner           varchar(50)               null comment '是否业主工单(1:是，0：否）',
    wxdw              varchar(255)              null comment '维修单位',
    zrdw              varchar(255)              null comment '责任单位',
    wxnrfa            varchar(2000)             null comment '维修内容及方案',
    jdry              varchar(50)               null comment '接单人员',
    gdwcsj            datetime                  null comment '规定完成时间',
    cssjflag          varchar(10)               null comment '派单超时时间标识（1：项目级，2：区域级，3：总部级）',
    csbz              varchar(500)              null comment '超时备注',
    yzxx_pk_owner     varchar(50)               null comment '业主主键',
    yzxx_pk_housetype varchar(50)               null comment '楼栋主键',
    yzxx_pk_house     varchar(50)               null comment '房产主键',
    yzxx_pk_corp      varchar(50)               null comment '小区主键',
    indoor            varchar(10)               null comment '室内（1：是，0：否）用于判断保修工单，室内的保修工单',
    pjbqnr            varchar(300)              null comment '评价标签内容',
    gdcsflag          varchar(10)               null comment '关单超时时间标识（1：项目级，2：区域级，3：总部级）',
    gbyysm            varchar(500)              null comment '暂不处理及非正常关闭状态需增加原因说明文本框',
    udesk_ticket_id   int unsigned              null comment 'udesk平台工单Id',
    udesk_record_url  varchar(500)              null comment 'udesk平台通话记录url',
    satisfy_degree    varchar(1)                null comment '满意度（1：是，0：否）',
    constraint wywx_fault_repair_id
        unique (id)
)
    comment '用户报修信息表' charset = utf8mb4;

create index wywx_fault_repair_concatphone
    on wywx_fault_repair_2016 (concatphone);

create index wywx_fault_repair_cssjflag
    on wywx_fault_repair_2016 (cssjflag);

create index wywx_fault_repair_deptid
    on wywx_fault_repair_2016 (deptid);

create index wywx_fault_repair_deptname
    on wywx_fault_repair_2016 (deptname);

create index wywx_fault_repair_dics_id
    on wywx_fault_repair_2016 (dics_id);

create index wywx_fault_repair_dics_id4
    on wywx_fault_repair_2016 (dics_id4);

create index wywx_fault_repair_dispatchmanid
    on wywx_fault_repair_2016 (dispatchmanid);

create index wywx_fault_repair_dispatchphone
    on wywx_fault_repair_2016 (dispatchphone);

create index wywx_fault_repair_faultcode
    on wywx_fault_repair_2016 (faultcode);

create index wywx_fault_repair_gdcsflag
    on wywx_fault_repair_2016 (gdcsflag);

create index wywx_fault_repair_indoor
    on wywx_fault_repair_2016 (indoor);

create index wywx_fault_repair_inserttime
    on wywx_fault_repair_2016 (inserttime);

create index wywx_fault_repair_isdeleted
    on wywx_fault_repair_2016 (isdeleted);

create index wywx_fault_repair_openid
    on wywx_fault_repair_2016 (openid);

create index wywx_fault_repair_pk_equipment
    on wywx_fault_repair_2016 (pk_equipment);

create index wywx_fault_repair_repairmanid
    on wywx_fault_repair_2016 (repairmanid);

create index wywx_fault_repair_repairmanphone
    on wywx_fault_repair_2016 (repairmanphone);

create index wywx_fault_repair_source
    on wywx_fault_repair_2016 (source);

create index wywx_fault_repair_status
    on wywx_fault_repair_2016 (status);

create index wywx_fault_repair_sub_tel
    on wywx_fault_repair_2016 (sub_tel);

create index wywx_fault_repair_type
    on wywx_fault_repair_2016 (type);

alter table wywx_fault_repair_2016
    add primary key (id);

create table wywx_fault_repair_2017
(
    id                varchar(32) charset utf8  not null comment '主键',
    faultcode         varchar(50) charset utf8  null comment '报修编号',
    address           varchar(200) charset utf8 null comment '用户地址',
    ownername         varchar(50) charset utf8  null comment '业主姓名',
    concatphone       varchar(50) charset utf8  null comment '联系电话',
    dics_id           varchar(32) charset utf8  null comment '报修类型pk(报修1级分类)(服务大类)',
    dics_id2          varchar(32) charset utf8  null comment '报修类型pk(报修2级分类)(服务类型)',
    dics_id3          varchar(32) charset utf8  null comment '报修类型pk(报修3级分类)(具体类别)',
    dics_id4          varchar(32)               null,
    dics_code         varchar(32) charset utf8  null comment '报修类型编码(报修1级分类)(服务大类)',
    dics_code2        varchar(32) charset utf8  null comment '报修类型编码(报修2级分类)(服务类型)',
    dics_code3        varchar(32) charset utf8  null comment '报修类型编码(报修3级分类)(具体类别)',
    dics_code4        varchar(32)               null,
    dics_name         varchar(50) charset utf8  null comment '报修类型名称(报修1级分类)(服务大类)',
    dics_name2        varchar(50) charset utf8  null comment '报修类型名称(报修2级分类)(服务类型)',
    dics_name3        varchar(50) charset utf8  null comment '报修类型名称(报修3级分类)(类别)',
    dics_name4        varchar(50)               null,
    faultinfo         varchar(500) charset utf8 null comment '报修描述信息',
    dispatchmanid     varchar(50) charset utf8  null comment '派工人员（管家）人员ID（wywx_serviceman表servicewxid，type=1）微信openid',
    dispatchman       varchar(50) charset utf8  null comment '派工人员（管家）姓名',
    dispatchphone     varchar(50) charset utf8  null comment '派工人员（管家）电话',
    dispatchcomment   varchar(500) charset utf8 null comment '派工备注（管家派工处理时输入文本报修描述说明，语音描述作为附件存在wywx_file_attachment表）',
    dispatchtime      datetime                  null comment '派工时间',
    repairmanid       varchar(32) charset utf8  null comment '维修（员工）人员ID（wywx_serviceman表servicewxid，type=2）微信openid',
    repairman         varchar(50) charset utf8  null comment '维修人员姓名',
    repairmanphone    varchar(50) charset utf8  null comment '维修人员电话',
    repairedtime      datetime                  null comment '维修完成时间',
    repaircomment     varchar(500)              null comment '维修完成备注（派工给员工处理时输入文本，语音描述作为附件存在wywx_file_attachment表）',
    comment           varchar(500) charset utf8 null comment '评价意见',
    commenttime       datetime                  null comment '评价时间',
    evaluate_respons  varchar(2) charset utf8   null comment '评价-响应速度（1-5）星',
    evaluate_service  varchar(2) charset utf8   null comment '评价-服务态度（1-5）星',
    evaluate_result   varchar(2) charset utf8   null comment '评价-处理结果（1-5）星',
    evaluate_all      varchar(2)                null comment '评价分数（5星，有半星情况，值：1-10）',
    status            varchar(2) charset utf8   null comment '//状态标识（0：待派工，1：已派工，2：完成维修，3：完成评价，6：物业管家同意，7：物业管家拒绝，8：已放行，10：暂不处理，11：非正常关闭）（6、7、8属于放行条）',
    type              varchar(10) charset utf8  null comment '类别（1：报修，2：一键报管家，3：投诉，4：建议，5：搬家放行）',
    source            varchar(50)               null comment '工单来源（fwh：服务号，qyh：企业号，jk：接口，web：后台系统）',
    sub_tel           varchar(50)               null comment 'app接口提交工单时提交人手机号',
    lrryid            varchar(50) charset utf8  null comment '录入人员ID',
    lrrymc            varchar(50) charset utf8  null comment '录入人员姓名',
    openid            varchar(200) charset utf8 null comment '微信端报修人员openid',
    nickname          varchar(100) charset utf8 null comment '微信端报修人员的昵称',
    imageurl          varchar(300) charset utf8 null comment '微信端报修人员头像',
    inserttime        datetime                  null comment '录入时间',
    updatetime        datetime                  null comment '时间戳',
    isdeleted         varchar(1) charset utf8   null comment '删除标志（0：不删除，1：删除）',
    deptid            varchar(50) charset utf8  null comment '部门id',
    deptname          varchar(50) charset utf8  null comment '部门名称',
    gdtb              varchar(1) default '0'    null comment '工单同步标示（0：未同步，1：同步成功，2：同步出错）',
    gdno              varchar(50)               null comment '工单系统返回工单编号',
    gderr             varchar(500)              null comment '工单系统返回错误消息',
    pk_equipment      varchar(50)               null comment '设备ID',
    isowner           varchar(50)               null comment '是否业主工单(1:是，0：否）',
    wxdw              varchar(255)              null comment '维修单位',
    zrdw              varchar(255)              null comment '责任单位',
    wxnrfa            varchar(2000)             null comment '维修内容及方案',
    jdry              varchar(50)               null comment '接单人员',
    gdwcsj            datetime                  null comment '规定完成时间',
    cssjflag          varchar(10)               null comment '派单超时时间标识（1：项目级，2：区域级，3：总部级）',
    csbz              varchar(500)              null comment '超时备注',
    yzxx_pk_owner     varchar(50)               null comment '业主主键',
    yzxx_pk_housetype varchar(50)               null comment '楼栋主键',
    yzxx_pk_house     varchar(50)               null comment '房产主键',
    yzxx_pk_corp      varchar(50)               null comment '小区主键',
    indoor            varchar(10)               null comment '室内（1：是，0：否）用于判断保修工单，室内的保修工单',
    pjbqnr            varchar(300)              null comment '评价标签内容',
    gdcsflag          varchar(10)               null comment '关单超时时间标识（1：项目级，2：区域级，3：总部级）',
    gbyysm            varchar(500)              null comment '暂不处理及非正常关闭状态需增加原因说明文本框',
    udesk_ticket_id   int unsigned              null comment 'udesk平台工单Id',
    udesk_record_url  varchar(500)              null comment 'udesk平台通话记录url',
    satisfy_degree    varchar(1)                null comment '满意度（1：是，0：否）',
    constraint wywx_fault_repair_id
        unique (id)
)
    comment '用户报修信息表' charset = utf8mb4;

create index wywx_fault_repair_concatphone
    on wywx_fault_repair_2017 (concatphone);

create index wywx_fault_repair_cssjflag
    on wywx_fault_repair_2017 (cssjflag);

create index wywx_fault_repair_deptid
    on wywx_fault_repair_2017 (deptid);

create index wywx_fault_repair_deptname
    on wywx_fault_repair_2017 (deptname);

create index wywx_fault_repair_dics_id
    on wywx_fault_repair_2017 (dics_id);

create index wywx_fault_repair_dics_id4
    on wywx_fault_repair_2017 (dics_id4);

create index wywx_fault_repair_dispatchmanid
    on wywx_fault_repair_2017 (dispatchmanid);

create index wywx_fault_repair_dispatchphone
    on wywx_fault_repair_2017 (dispatchphone);

create index wywx_fault_repair_faultcode
    on wywx_fault_repair_2017 (faultcode);

create index wywx_fault_repair_gdcsflag
    on wywx_fault_repair_2017 (gdcsflag);

create index wywx_fault_repair_indoor
    on wywx_fault_repair_2017 (indoor);

create index wywx_fault_repair_inserttime
    on wywx_fault_repair_2017 (inserttime);

create index wywx_fault_repair_isdeleted
    on wywx_fault_repair_2017 (isdeleted);

create index wywx_fault_repair_openid
    on wywx_fault_repair_2017 (openid);

create index wywx_fault_repair_pk_equipment
    on wywx_fault_repair_2017 (pk_equipment);

create index wywx_fault_repair_repairmanid
    on wywx_fault_repair_2017 (repairmanid);

create index wywx_fault_repair_repairmanphone
    on wywx_fault_repair_2017 (repairmanphone);

create index wywx_fault_repair_source
    on wywx_fault_repair_2017 (source);

create index wywx_fault_repair_status
    on wywx_fault_repair_2017 (status);

create index wywx_fault_repair_sub_tel
    on wywx_fault_repair_2017 (sub_tel);

create index wywx_fault_repair_type
    on wywx_fault_repair_2017 (type);

alter table wywx_fault_repair_2017
    add primary key (id);

create table wywx_fault_repair_2018
(
    id                varchar(32) charset utf8  not null comment '主键',
    faultcode         varchar(50) charset utf8  null comment '报修编号',
    address           varchar(200) charset utf8 null comment '用户地址',
    ownername         varchar(50) charset utf8  null comment '业主姓名',
    concatphone       varchar(50) charset utf8  null comment '联系电话',
    dics_id           varchar(32) charset utf8  null comment '报修类型pk(报修1级分类)(服务大类)',
    dics_id2          varchar(32) charset utf8  null comment '报修类型pk(报修2级分类)(服务类型)',
    dics_id3          varchar(32) charset utf8  null comment '报修类型pk(报修3级分类)(具体类别)',
    dics_id4          varchar(32)               null,
    dics_code         varchar(32) charset utf8  null comment '报修类型编码(报修1级分类)(服务大类)',
    dics_code2        varchar(32) charset utf8  null comment '报修类型编码(报修2级分类)(服务类型)',
    dics_code3        varchar(32) charset utf8  null comment '报修类型编码(报修3级分类)(具体类别)',
    dics_code4        varchar(32)               null,
    dics_name         varchar(50) charset utf8  null comment '报修类型名称(报修1级分类)(服务大类)',
    dics_name2        varchar(50) charset utf8  null comment '报修类型名称(报修2级分类)(服务类型)',
    dics_name3        varchar(50) charset utf8  null comment '报修类型名称(报修3级分类)(类别)',
    dics_name4        varchar(50)               null,
    faultinfo         varchar(500) charset utf8 null comment '报修描述信息',
    dispatchmanid     varchar(50) charset utf8  null comment '派工人员（管家）人员ID（wywx_serviceman表servicewxid，type=1）微信openid',
    dispatchman       varchar(50) charset utf8  null comment '派工人员（管家）姓名',
    dispatchphone     varchar(50) charset utf8  null comment '派工人员（管家）电话',
    dispatchcomment   varchar(500) charset utf8 null comment '派工备注（管家派工处理时输入文本报修描述说明，语音描述作为附件存在wywx_file_attachment表）',
    dispatchtime      datetime                  null comment '派工时间',
    repairmanid       varchar(32) charset utf8  null comment '维修（员工）人员ID（wywx_serviceman表servicewxid，type=2）微信openid',
    repairman         varchar(50) charset utf8  null comment '维修人员姓名',
    repairmanphone    varchar(50) charset utf8  null comment '维修人员电话',
    repairedtime      datetime                  null comment '维修完成时间',
    repaircomment     varchar(500)              null comment '维修完成备注（派工给员工处理时输入文本，语音描述作为附件存在wywx_file_attachment表）',
    comment           varchar(500) charset utf8 null comment '评价意见',
    commenttime       datetime                  null comment '评价时间',
    evaluate_respons  varchar(2) charset utf8   null comment '评价-响应速度（1-5）星',
    evaluate_service  varchar(2) charset utf8   null comment '评价-服务态度（1-5）星',
    evaluate_result   varchar(2) charset utf8   null comment '评价-处理结果（1-5）星',
    evaluate_all      varchar(2)                null comment '评价分数（5星，有半星情况，值：1-10）',
    status            varchar(2) charset utf8   null comment '//状态标识（0：待派工，1：已派工，2：完成维修，3：完成评价，6：物业管家同意，7：物业管家拒绝，8：已放行，10：暂不处理，11：非正常关闭）（6、7、8属于放行条）',
    type              varchar(10) charset utf8  null comment '类别（1：报修，2：一键报管家，3：投诉，4：建议，5：搬家放行）',
    source            varchar(50)               null comment '工单来源（fwh：服务号，qyh：企业号，jk：接口，web：后台系统）',
    sub_tel           varchar(50)               null comment 'app接口提交工单时提交人手机号',
    lrryid            varchar(50) charset utf8  null comment '录入人员ID',
    lrrymc            varchar(50) charset utf8  null comment '录入人员姓名',
    openid            varchar(200) charset utf8 null comment '微信端报修人员openid',
    nickname          varchar(100) charset utf8 null comment '微信端报修人员的昵称',
    imageurl          varchar(300) charset utf8 null comment '微信端报修人员头像',
    inserttime        datetime                  null comment '录入时间',
    updatetime        datetime                  null comment '时间戳',
    isdeleted         varchar(1) charset utf8   null comment '删除标志（0：不删除，1：删除）',
    deptid            varchar(50) charset utf8  null comment '部门id',
    deptname          varchar(50) charset utf8  null comment '部门名称',
    gdtb              varchar(1) default '0'    null comment '工单同步标示（0：未同步，1：同步成功，2：同步出错）',
    gdno              varchar(50)               null comment '工单系统返回工单编号',
    gderr             varchar(500)              null comment '工单系统返回错误消息',
    pk_equipment      varchar(50)               null comment '设备ID',
    isowner           varchar(50)               null comment '是否业主工单(1:是，0：否）',
    wxdw              varchar(255)              null comment '维修单位',
    zrdw              varchar(255)              null comment '责任单位',
    wxnrfa            varchar(2000)             null comment '维修内容及方案',
    jdry              varchar(50)               null comment '接单人员',
    gdwcsj            datetime                  null comment '规定完成时间',
    cssjflag          varchar(10)               null comment '派单超时时间标识（1：项目级，2：区域级，3：总部级）',
    csbz              varchar(500)              null comment '超时备注',
    yzxx_pk_owner     varchar(50)               null comment '业主主键',
    yzxx_pk_housetype varchar(50)               null comment '楼栋主键',
    yzxx_pk_house     varchar(50)               null comment '房产主键',
    yzxx_pk_corp      varchar(50)               null comment '小区主键',
    indoor            varchar(10)               null comment '室内（1：是，0：否）用于判断保修工单，室内的保修工单',
    pjbqnr            varchar(300)              null comment '评价标签内容',
    gdcsflag          varchar(10)               null comment '关单超时时间标识（1：项目级，2：区域级，3：总部级）',
    gbyysm            varchar(500)              null comment '暂不处理及非正常关闭状态需增加原因说明文本框',
    udesk_ticket_id   int unsigned              null comment 'udesk平台工单Id',
    udesk_record_url  varchar(500)              null comment 'udesk平台通话记录url',
    satisfy_degree    varchar(1)                null comment '满意度（1：是，0：否）',
    constraint wywx_fault_repair_id
        unique (id)
)
    comment '用户报修信息表' engine = MyISAM
                      charset = utf8mb4;

create index wywx_fault_repair_concatphone
    on wywx_fault_repair_2018 (concatphone);

create index wywx_fault_repair_cssjflag
    on wywx_fault_repair_2018 (cssjflag);

create index wywx_fault_repair_deptid
    on wywx_fault_repair_2018 (deptid);

create index wywx_fault_repair_deptname
    on wywx_fault_repair_2018 (deptname);

create index wywx_fault_repair_dics_id
    on wywx_fault_repair_2018 (dics_id);

create index wywx_fault_repair_dics_id4
    on wywx_fault_repair_2018 (dics_id4);

create index wywx_fault_repair_dispatchmanid
    on wywx_fault_repair_2018 (dispatchmanid);

create index wywx_fault_repair_dispatchphone
    on wywx_fault_repair_2018 (dispatchphone);

create index wywx_fault_repair_faultcode
    on wywx_fault_repair_2018 (faultcode);

create index wywx_fault_repair_gdcsflag
    on wywx_fault_repair_2018 (gdcsflag);

create index wywx_fault_repair_indoor
    on wywx_fault_repair_2018 (indoor);

create index wywx_fault_repair_inserttime
    on wywx_fault_repair_2018 (inserttime);

create index wywx_fault_repair_isdeleted
    on wywx_fault_repair_2018 (isdeleted);

create index wywx_fault_repair_openid
    on wywx_fault_repair_2018 (openid);

create index wywx_fault_repair_pk_equipment
    on wywx_fault_repair_2018 (pk_equipment);

create index wywx_fault_repair_repairmanid
    on wywx_fault_repair_2018 (repairmanid);

create index wywx_fault_repair_repairmanphone
    on wywx_fault_repair_2018 (repairmanphone);

create index wywx_fault_repair_source
    on wywx_fault_repair_2018 (source);

create index wywx_fault_repair_status
    on wywx_fault_repair_2018 (status);

create index wywx_fault_repair_sub_tel
    on wywx_fault_repair_2018 (sub_tel);

create index wywx_fault_repair_type
    on wywx_fault_repair_2018 (type);

alter table wywx_fault_repair_2018
    add primary key (id);

create table wywx_fault_repair_copy
(
    id                varchar(32) charset utf8  not null comment '主键',
    faultcode         varchar(50) charset utf8  null comment '报修编号',
    address           varchar(200) charset utf8 null comment '用户地址',
    ownername         varchar(50) charset utf8  null comment '业主姓名',
    concatphone       varchar(50) charset utf8  null comment '联系电话',
    dics_id           varchar(32) charset utf8  null comment '报修类型pk(报修1级分类)(服务大类)',
    dics_id2          varchar(32) charset utf8  null comment '报修类型pk(报修2级分类)(服务类型)',
    dics_id3          varchar(32) charset utf8  null comment '报修类型pk(报修3级分类)(具体类别)',
    dics_id4          varchar(32)               null,
    dics_code         varchar(32) charset utf8  null comment '报修类型编码(报修1级分类)(服务大类)',
    dics_code2        varchar(32) charset utf8  null comment '报修类型编码(报修2级分类)(服务类型)',
    dics_code3        varchar(32) charset utf8  null comment '报修类型编码(报修3级分类)(具体类别)',
    dics_code4        varchar(32)               null,
    dics_name         varchar(50) charset utf8  null comment '报修类型名称(报修1级分类)(服务大类)',
    dics_name2        varchar(50) charset utf8  null comment '报修类型名称(报修2级分类)(服务类型)',
    dics_name3        varchar(50) charset utf8  null comment '报修类型名称(报修3级分类)(类别)',
    dics_name4        varchar(50)               null,
    faultinfo         varchar(500) charset utf8 null comment '报修描述信息',
    dispatchmanid     varchar(50) charset utf8  null comment '派工人员（管家）人员ID（wywx_serviceman表servicewxid，type=1）微信openid',
    dispatchman       varchar(50) charset utf8  null comment '派工人员（管家）姓名',
    dispatchphone     varchar(50) charset utf8  null comment '派工人员（管家）电话',
    dispatchcomment   varchar(500) charset utf8 null comment '派工备注（管家派工处理时输入文本报修描述说明，语音描述作为附件存在wywx_file_attachment表）',
    dispatchtime      datetime                  null comment '派工时间',
    repairmanid       varchar(32) charset utf8  null comment '维修（员工）人员ID（wywx_serviceman表servicewxid，type=2）微信openid',
    repairman         varchar(50) charset utf8  null comment '维修人员姓名',
    repairmanphone    varchar(50) charset utf8  null comment '维修人员电话',
    repairedtime      datetime                  null comment '维修完成时间',
    repaircomment     varchar(500)              null comment '维修完成备注（派工给员工处理时输入文本，语音描述作为附件存在wywx_file_attachment表）',
    comment           varchar(500) charset utf8 null comment '评价意见',
    commenttime       datetime                  null comment '评价时间',
    evaluate_respons  varchar(2) charset utf8   null comment '评价-响应速度（1-5）星',
    evaluate_service  varchar(2) charset utf8   null comment '评价-服务态度（1-5）星',
    evaluate_result   varchar(2) charset utf8   null comment '评价-处理结果（1-5）星',
    evaluate_all      varchar(2)                null comment '评价分数（5星，有半星情况，值：1-10）',
    status            varchar(2) charset utf8   null comment '//状态标识（0：待派工，1：已派工，2：完成维修，3：完成评价，6：物业管家同意，7：物业管家拒绝，8：已放行，10：暂不处理，11：非正常关闭）（6、7、8属于放行条）',
    type              varchar(10) charset utf8  null comment '类别（1：报修，2：一键报管家，3：投诉，4：建议，5：搬家放行）',
    source            varchar(50)               null comment '工单来源（fwh：服务号，qyh：企业号，jk：接口，web：后台系统）',
    sub_tel           varchar(50)               null comment 'app接口提交工单时提交人手机号',
    lrryid            varchar(50) charset utf8  null comment '录入人员ID',
    lrrymc            varchar(50) charset utf8  null comment '录入人员姓名',
    openid            varchar(200) charset utf8 null comment '微信端报修人员openid',
    nickname          varchar(100) charset utf8 null comment '微信端报修人员的昵称',
    imageurl          varchar(300) charset utf8 null comment '微信端报修人员头像',
    inserttime        datetime                  null comment '录入时间',
    updatetime        datetime                  null comment '时间戳',
    isdeleted         varchar(1) charset utf8   null comment '删除标志（0：不删除，1：删除）',
    deptid            varchar(50) charset utf8  null comment '部门id',
    deptname          varchar(50) charset utf8  null comment '部门名称',
    gdtb              varchar(1) default '0'    null comment '工单同步标示（0：未同步，1：同步成功，2：同步出错）',
    gdno              varchar(50)               null comment '工单系统返回工单编号',
    gderr             varchar(500)              null comment '工单系统返回错误消息',
    pk_equipment      varchar(50)               null comment '设备ID',
    isowner           varchar(50)               null comment '是否业主工单(1:是，0：否）',
    wxdw              varchar(255)              null comment '维修单位',
    zrdw              varchar(255)              null comment '责任单位',
    wxnrfa            varchar(2000)             null comment '维修内容及方案',
    jdry              varchar(50)               null comment '接单人员',
    gdwcsj            datetime                  null comment '规定完成时间',
    cssjflag          varchar(10)               null comment '派单超时时间标识（1：项目级，2：区域级，3：总部级）',
    csbz              varchar(500)              null comment '超时备注',
    yzxx_pk_owner     varchar(50)               null comment '业主主键',
    yzxx_pk_housetype varchar(50)               null comment '楼栋主键',
    yzxx_pk_house     varchar(50)               null comment '房产主键',
    yzxx_pk_corp      varchar(50)               null comment '小区主键',
    indoor            varchar(10)               null comment '室内（1：是，0：否）用于判断保修工单，室内的保修工单',
    pjbqnr            varchar(300)              null comment '评价标签内容',
    gdcsflag          varchar(10)               null comment '关单超时时间标识（1：项目级，2：区域级，3：总部级）',
    gbyysm            varchar(500)              null comment '暂不处理及非正常关闭状态需增加原因说明文本框',
    udesk_ticket_id   int unsigned              null comment 'udesk平台工单Id',
    udesk_record_url  varchar(500)              null comment 'udesk平台通话记录url',
    satisfy_degree    varchar(1)                null comment '满意度（1：是，0：否）',
    constraint wywx_fault_repair_id
        unique (id)
)
    comment '用户报修信息表' charset = utf8mb4;

create index wywx_fault_repair_concatphone
    on wywx_fault_repair_copy (concatphone);

create index wywx_fault_repair_cssjflag
    on wywx_fault_repair_copy (cssjflag);

create index wywx_fault_repair_deptid
    on wywx_fault_repair_copy (deptid);

create index wywx_fault_repair_deptname
    on wywx_fault_repair_copy (deptname);

create index wywx_fault_repair_dics_id
    on wywx_fault_repair_copy (dics_id);

create index wywx_fault_repair_dics_id4
    on wywx_fault_repair_copy (dics_id4);

create index wywx_fault_repair_dispatchmanid
    on wywx_fault_repair_copy (dispatchmanid);

create index wywx_fault_repair_dispatchphone
    on wywx_fault_repair_copy (dispatchphone);

create index wywx_fault_repair_faultcode
    on wywx_fault_repair_copy (faultcode);

create index wywx_fault_repair_gdcsflag
    on wywx_fault_repair_copy (gdcsflag);

create index wywx_fault_repair_indoor
    on wywx_fault_repair_copy (indoor);

create index wywx_fault_repair_inserttime
    on wywx_fault_repair_copy (inserttime);

create index wywx_fault_repair_isdeleted
    on wywx_fault_repair_copy (isdeleted);

create index wywx_fault_repair_openid
    on wywx_fault_repair_copy (openid);

create index wywx_fault_repair_pk_equipment
    on wywx_fault_repair_copy (pk_equipment);

create index wywx_fault_repair_repairmanid
    on wywx_fault_repair_copy (repairmanid);

create index wywx_fault_repair_repairmanphone
    on wywx_fault_repair_copy (repairmanphone);

create index wywx_fault_repair_source
    on wywx_fault_repair_copy (source);

create index wywx_fault_repair_status
    on wywx_fault_repair_copy (status);

create index wywx_fault_repair_sub_tel
    on wywx_fault_repair_copy (sub_tel);

create index wywx_fault_repair_type
    on wywx_fault_repair_copy (type);

alter table wywx_fault_repair_copy
    add primary key (id);

create table wywx_file_attachment
(
    id           varchar(32)  not null comment '主键',
    relatedtable varchar(50)  null comment '关联表名',
    relatedid    varchar(32)  null comment '关联主键ID',
    relatedtype  varchar(50)  null comment '关联类别（1：新建报修（语音、图片），2：派工备注（语音），3：维修处理前（图片），4：维修处理后（图片）），5：维修处理（语音），6：评价处理（语音、图片）',
    filepath     varchar(500) null comment '文件路径',
    filetype     varchar(50)  null comment '文件类型',
    filesize     int          null comment '文件大小',
    sortorder    int          null comment '排序（多个图片排序用）',
    isdeleted    varchar(1)   null comment '删除标志（0：不删除，1：删除）',
    updatetime   datetime     null comment '时间戳',
    inserttime   datetime     null comment '录入时间',
    constraint wywx_file_attachment_id
        unique (id)
)
    comment '附件信息表';

create index wywx_file_attachment_filetype
    on wywx_file_attachment (filetype);

create index wywx_file_attachment_inserttime
    on wywx_file_attachment (inserttime);

create index wywx_file_attachment_isdeleted
    on wywx_file_attachment (isdeleted);

create index wywx_file_attachment_relatedid
    on wywx_file_attachment (relatedid);

create index wywx_file_attachment_relatedtable
    on wywx_file_attachment (relatedtable);

create index wywx_file_attachment_relatedtype
    on wywx_file_attachment (relatedtype);

alter table wywx_file_attachment
    add primary key (id);

create table wywx_fr_chuli
(
    id           varchar(32)   not null comment '主键',
    relatedtable varchar(50)   null comment '关联表名',
    relatedid    varchar(32)   null comment '关联主键ID',
    relatedtype  varchar(50)   null comment '关联类别（1：维修日志，2：转办情况）',
    beizhu       varchar(1000) null comment '备注说明',
    zbry         varchar(50)   null comment '转办人员',
    zbryid       varchar(50)   null comment '转办人员ID（企业号userid）',
    zbryphone    varchar(50)   null comment '转办人员手机',
    lrry         varchar(50)   null comment '录入人员',
    lrryid       varchar(50)   null comment '录入人员ID（企业号userid）',
    lrryphone    varchar(50)   null comment '录入人员手机',
    inserttime   datetime      null comment '录入时间',
    constraint wywx_fr_chuli_id
        unique (id)
)
    comment '工单流程信息表';

create index wywx_fr_chuli_inserttime
    on wywx_fr_chuli (inserttime);

create index wywx_fr_chuli_relatedid
    on wywx_fr_chuli (relatedid);

create index wywx_fr_chuli_relatedtable
    on wywx_fr_chuli (relatedtable);

create index wywx_fr_chuli_relatedtype
    on wywx_fr_chuli (relatedtype);

alter table wywx_fr_chuli
    add primary key (id);

create table wywx_fr_faqr
(
    id         varchar(32)   not null comment '主键',
    relatedid  varchar(32)   null comment '关联工单主键ID（wywx_fault_repair表主键ID）',
    zdfasj     datetime      null comment '制定方案时间',
    fams       varchar(2000) null comment '方案描述',
    lrry       varchar(50)   null comment '录入人员',
    lrryid     varchar(50)   null comment '录入人员ID（企业号userid）',
    lrryphone  varchar(50)   null comment '录入人员手机',
    inserttime datetime      null comment '录入时间'
)
    comment '工单关联信息--方案确认';

create table wywx_fr_hbjz
(
    id         varchar(32)   not null comment '主键',
    relatedid  varchar(32)   null comment '关联工单主键ID（wywx_fault_repair表主键ID）',
    hbsj       datetime      null comment '汇报时间',
    jzzk       varchar(500)  null comment '进展状况',
    jzsm       varchar(2000) null comment '进展说明',
    khqz       varchar(50)   null comment '客户签字',
    hbry       varchar(50)   null comment '汇报人',
    lrry       varchar(50)   null comment '录入人员',
    lrryid     varchar(50)   null comment '录入人员ID（企业号userid）',
    lrryphone  varchar(50)   null comment '录入人员手机',
    inserttime datetime      null comment '录入时间'
)
    comment '工单关联信息--汇报进展';

create table wywx_fr_lxkh
(
    id         varchar(32)   not null comment '主键'
        primary key,
    relatedid  varchar(32)   null comment '关联工单主键ID（wywx_fault_repair表主键ID）',
    khyj       varchar(500)  null comment '客户意见',
    lxkhsj     datetime      null comment '联系客户时间',
    bzms       varchar(2000) null comment '描述备注',
    lxry       varchar(50)   null comment '联系人',
    lrry       varchar(50)   null comment '录入人员',
    lrryid     varchar(50)   null comment '录入人员ID（企业号userid）',
    lrryphone  varchar(50)   null comment '录入人员手机',
    inserttime datetime      null comment '录入时间'
)
    comment '工单关联信息--联系客户';

create table wywx_fr_wxpd
(
    id         varchar(32)   not null comment '主键',
    relatedid  varchar(32)   null comment '关联工单主键ID（wywx_fault_repair表主键ID）',
    zrdw       varchar(255)  null comment '责任单位',
    wxdw       varchar(255)  null comment '维修单位',
    pdsj       datetime      null comment '派单时间',
    bzms       varchar(2000) null comment '描述备注',
    pdry       varchar(50)   null comment '派单人员',
    jdry       varchar(50)   null comment '接单人员',
    lrry       varchar(50)   null comment '录入人员',
    lrryid     varchar(50)   null comment '录入人员ID（企业号userid）',
    lrryphone  varchar(50)   null comment '录入人员手机',
    inserttime datetime      null comment '录入时间'
)
    comment '工单关联信息--维修派单';

create table wywx_gdcs_msg_log
(
    id             varchar(32) charset utf8mb4  not null comment '主键'
        primary key,
    name           varchar(50)                  null comment '接收人员姓名',
    phone          varchar(32) charset utf8mb4  null comment '手机号',
    wxuserid       varchar(50) charset utf8mb4  null comment '企业号userid',
    gdid           varchar(50) charset utf8mb4  null comment '工单ID',
    msg            varchar(200) charset utf8mb4 null comment '消息内容',
    cssjflag       varchar(2)                   null comment '级别（1：项目级，2：区域级，3：总部级）',
    sendstatus     varchar(10) charset utf8mb4  null comment '发送短信是否成功（0：未发送，3：不发送，1：成功，2：失败）',
    sendtime       datetime                     null comment '发送短信时间',
    sendstatus_qyh varchar(10)                  null comment '发送企业号消息是否成功（0：未发送，3：不发送，1：成功，2：失败）',
    sendtime_qyh   datetime                     null comment '发送企业号时间',
    inserttime     datetime                     null comment '录入时间'
)
    comment '工单完成超时（预警超时，一级超时，二级超时）提醒消息表';

create index wywx_gdcs_msg_log_1
    on wywx_gdcs_msg_log (cssjflag);

create index wywx_gdcs_msg_log_2
    on wywx_gdcs_msg_log (gdid);

create index wywx_gdcs_msg_log_3
    on wywx_gdcs_msg_log (inserttime);

create table wywx_gdzrry_bxgd
(
    ID         varchar(32) not null,
    name       varchar(50) null comment '姓名',
    wxid       varchar(50) null comment '微信服务号OpenID，用于发送微信消息使用',
    wxuserid   varchar(50) null comment '微信企业号UserID，用于发送微信消息使用',
    phone      varchar(50) null comment '手机号',
    lrryid     varchar(50) null comment '录入人员ID',
    lrrymc     varchar(50) null comment '录入人员姓名',
    inserttime datetime    null comment '录入时间',
    deptid     varchar(50) null comment '部门id',
    deptname   varchar(50) null comment '部门名称'
)
    comment '保修关单督办责任人配置';

create table wywx_gdzrry_wygd
(
    ID         varchar(32) not null,
    name       varchar(50) null comment '姓名',
    wxid       varchar(50) null comment '微信服务号OpenID，用于发送微信消息使用',
    wxuserid   varchar(50) null comment '微信企业号UserID，用于发送微信消息使用',
    phone      varchar(50) null comment '手机号',
    lrryid     varchar(50) null comment '录入人员ID',
    lrrymc     varchar(50) null comment '录入人员姓名',
    inserttime datetime    null comment '录入时间',
    deptid     varchar(50) null comment '部门id',
    deptname   varchar(50) null comment '部门名称'
)
    comment '物业关单督办责任人配置';

create table wywx_gjxx
(
    id         varchar(32)  not null comment '主键'
        primary key,
    gjxm       varchar(20)  null comment '管家姓名',
    gxqy       varchar(500) null comment '管辖区域',
    gjdh       varchar(50)  null comment '管家电话',
    gjbz       varchar(500) null comment '管家备注',
    logo       varchar(500) null comment '管家头像图片路径',
    sortorder  int          null comment '排序',
    dics_id    varchar(50)  null comment '类别(字典表sys_dics的管家信息下类别ID)',
    dics_name  varchar(50)  null comment '类别(字典表sys_dics的管家信息下类别name)',
    lrryid     varchar(50)  null comment '录入人员ID',
    lrrymc     varchar(50)  null comment '录入人员姓名',
    inserttime datetime     null comment '录入时间',
    updatetime datetime     null comment '时间戳',
    isdeleted  varchar(1)   null comment '删除标志（0：不删除，1：删除）',
    deptid     varchar(50)  null comment '部门id',
    deptname   varchar(50)  null comment '部门名称'
)
    comment '社区黄页信息';

create table wywx_msg_mb
(
    ID         varchar(32)  not null
        primary key,
    name       varchar(100) null comment '模版名称',
    mbid       varchar(100) null comment '微信模版ID，用于发送微信消息使用',
    mbnr       varchar(500) null comment '模版内容',
    lrryid     varchar(50)  null comment '录入人员ID',
    lrrymc     varchar(50)  null comment '录入人员姓名',
    inserttime datetime     null comment '录入时间',
    deptid     varchar(50)  null comment '部门id',
    deptname   varchar(50)  null comment '部门名称'
)
    comment '微信提醒信息模版';

create table wywx_position_sort
(
    id   varchar(50) not null
        primary key,
    nm   varchar(50) null,
    sort int(10)     null
);

create table wywx_qyhdept_tb
(
    ID         varchar(32)  not null comment '微信企业号部门ID'
        primary key,
    DPID       varchar(32)  not null comment '微信企业号上级部门ID，0表示根节点',
    SYSDID     varchar(500) null comment '系统(sysdept表）部门ID，0表示根节点',
    SYSDPID    varchar(100) null comment '系统(sysdept表）上级部门ID，0表示根节点',
    DSORT      int          null comment '部门序号',
    DCODE      varchar(40)  null comment '部门编号',
    DNAME      varchar(255) null,
    DSNAME     varchar(500) null comment '部门名称-简称short',
    DLNAME     varchar(120) null comment '部门名称-全称long',
    DTYPE      varchar(32)  null comment '部门类别',
    DLVL       int          null comment '部门级别，root：0',
    LEAF       int          null comment '是否为叶子节点（是：1，否：0）',
    inserttime datetime     not null comment '更新时间',
    updatetime datetime     null,
    ISDELETED  varchar(1)   null comment '删除标示（0：不删除，1：删除）'
)
    comment '系统框架部门表';

create table wywx_qyhuser_tb
(
    id         varchar(32)                         not null,
    userid     varchar(100)                        null comment '微信企业号userid',
    name       varchar(100) charset utf8           null comment '姓名',
    department varchar(500)                        null comment '微信企业号部门deptid(1,2）',
    position   varchar(100) charset utf8           null comment '岗位',
    mobile     varchar(50) charset utf8            null comment '手机号',
    gender     varchar(50)                         null comment '性别',
    email      varchar(255)                        null comment 'Email',
    weixinid   varchar(100) charset utf8           null comment '微信号',
    avatar     varchar(500) charset utf8           null comment '头像',
    status     varchar(50) charset utf8            null comment '状态(1=已关注，2=已冻结，4=未关注)',
    extattr    varchar(500)                        null,
    tbflag     varchar(1)                          null comment '同步标识(0:录入，1：已经导入serviceman表)',
    gzhdeptid  varchar(50)                         null,
    deptname   varchar(50)                         null,
    deptid     varchar(50)                         null,
    inserttime datetime                            null comment '创建时间',
    updatetime datetime                            null,
    isdeleted  varchar(1) charset utf8 default '0' null comment '删除标志（0：不删除，1：删除）',
    constraint wywx_user_id
        unique (id)
)
    comment '企业号用户信息' charset = utf8mb4;

create index wywx_user_phone
    on wywx_qyhuser_tb (mobile);

create index wywx_user_userid
    on wywx_qyhuser_tb (userid);

alter table wywx_qyhuser_tb
    add primary key (id);

create table wywx_serviceman
(
    id               varchar(32)   not null,
    servicename      varchar(50)   null comment '姓名',
    serviceworkphone varchar(50)   null comment '工作电话',
    servicephone     varchar(50)   null comment '电话',
    servicewxid      varchar(50)   null comment '微信服务号OpenID，用于发送微信消息使用',
    serviceposition  varchar(32)   null comment '服务人员岗位（员工岗位、管家岗位）',
    servicewxqyuid   varchar(50)   null comment '微信企业号UserID，用于发送微信消息使用',
    servicewxqydid   varchar(50)   null comment '企业号用户部门deptid',
    pkhousetype      varchar(2000) null comment '楼栋主键数组',
    housetypename    varchar(2000) null comment '楼栋名称数组',
    type             varchar(1)    null comment '人员类别（1：管家，2：员工，3：保安）',
    gdlbid           varchar(2000) null comment '工单类别ID',
    gdlbmc           varchar(2000) null comment '工单类别名称',
    lrryid           varchar(50)   null comment '录入人员ID',
    lrrymc           varchar(50)   null comment '录入人员姓名',
    inserttime       datetime      null comment '录入时间',
    updatetime       datetime      null comment '时间戳',
    isdeleted        varchar(1)    null comment '删除标志（0：不删除，1：删除）',
    userid           varchar(50)   null,
    deptid           varchar(50)   null comment '部门ID',
    deptname         varchar(50)   null comment '部门名称',
    inputsrc         varchar(10)   null comment '录入来源(0：录入，1：企业号用户导入)',
    constraint wywx_serviceman_id
        unique (id)
)
    comment '服务人员信息表';

create index wywx_serviceman_phone
    on wywx_serviceman (servicephone);

create index wywx_serviceman_servicewxqyuid
    on wywx_serviceman (servicewxqyuid);

create index wywx_serviceman_wxid
    on wywx_serviceman (servicewxid);

alter table wywx_serviceman
    add primary key (id);

create table wywx_serviceman_atts
(
    id             varchar(50)   not null
        primary key,
    servicephone   varchar(255)  null comment '手机，关联服务人员',
    servicewxqyuid varchar(50)   null,
    logo           varchar(500)  null comment '头像',
    responsibility varchar(1000) null comment '岗位职责',
    lrryid         varchar(50)   null comment '录入人员ID',
    lrrymc         varchar(50)   null comment '录入人员姓名',
    inserttime     datetime      null comment '录入时间',
    updatetime     datetime      null comment '时间戳',
    isdeleted      varchar(1)    null comment '删除标志（0：不删除，1：删除）'
);

create table wywx_sms_log
(
    id         varchar(32)  not null comment '主键'
        primary key,
    phone      varchar(32)  null comment '手机号',
    verifycode varchar(20)  null comment '验证码',
    msg        varchar(200) null comment '短信内容',
    sendstatus varchar(20)  null comment '发送是否成功（1：成功，其他为错误码）',
    gzhdeptid  varchar(32)  null comment '公众号所在单位',
    inserttime datetime     null comment '录入时间'
)
    charset = utf8mb4;

create table wywx_sqhy
(
    id         varchar(32)  not null comment '主键'
        primary key,
    sjjc       varchar(20)  null comment '商家简称',
    sjmc       varchar(50)  null comment '商家名称',
    fwnr       varchar(500) null comment '服务内容',
    sjdh       varchar(50)  null comment '商家电话',
    sjdz       varchar(100) null comment '商家地址',
    logo       varchar(500) null comment '商家lOGO图片路径',
    sortorder  int          null comment '排序',
    dics_id    varchar(50)  null comment '类别(字典表sys_dics的社区黄页下类别ID)',
    dics_name  varchar(50)  null comment '类别(字典表sys_dics的社区黄页下类别name)',
    lrryid     varchar(50)  null comment '录入人员ID',
    lrrymc     varchar(50)  null comment '录入人员姓名',
    inserttime datetime     null comment '录入时间',
    updatetime datetime     null comment '时间戳',
    isdeleted  varchar(1)   null comment '删除标志（0：不删除，1：删除）',
    deptid     varchar(50)  null comment '部门id',
    deptname   varchar(50)  null comment '部门名称'
)
    comment '社区黄页信息';

create table wywx_tsclry
(
    ID         varchar(32) not null
        primary key,
    name       varchar(50) null comment '姓名',
    wxid       varchar(50) null comment '微信ID，用于发送微信消息使用',
    phone      varchar(50) null comment '手机号',
    lrryid     varchar(50) null comment '录入人员ID',
    lrrymc     varchar(50) null comment '录入人员姓名',
    inserttime datetime    null comment '录入时间',
    deptid     varchar(50) null comment '部门id',
    deptname   varchar(50) null comment '部门名称'
)
    comment '投诉处理人员信息表
业主投诉后，接收投诉微信提醒人员列表';

create table wywx_user
(
    id         int(11) unsigned auto_increment,
    openid     varchar(100) charset utf8           null comment '微信服务号openid',
    userid     varchar(50)                         null comment '微信企业号userid',
    userdid    varchar(50)                         null comment '微信企业号部门deptid(1,2）',
    nickname   varchar(100) charset utf8           null comment '昵称',
    imageurl   varchar(200) charset utf8           null comment '头像',
    phone      varchar(50) charset utf8            null comment '手机号',
    inserttime datetime                            null comment '创建时间',
    vname      varchar(100) charset utf8           null comment '业主姓名',
    pk_owner   varchar(100) charset utf8           null comment '物业业主表主键',
    address    varchar(255)                        null comment '地址',
    deptid     varchar(50) charset utf8            null comment '部门id',
    deptname   varchar(50) charset utf8            null comment '部门名称',
    gzhdeptid  varchar(50)                         null comment '公众号关联部门ID',
    isdeleted  varchar(1) charset utf8 default '0' null comment '删除标志（0：不删除，1：删除）',
    constraint wywx_user_id
        unique (id)
)
    comment '业务用户表' charset = utf8mb4;

create index wywx_user_openid
    on wywx_user (openid);

create index wywx_user_phone
    on wywx_user (phone);

create index wywx_user_pkowner
    on wywx_user (pk_owner);

alter table wywx_user
    add primary key (id);

create table wywx_wbclry
(
    ID         varchar(32) not null,
    name       varchar(50) null comment '姓名',
    wxid       varchar(50) null comment '微信服务号OpenID，用于发送微信消息使用',
    wxuserid   varchar(50) null comment '微信企业号UserID，用于发送微信消息使用',
    phone      varchar(50) null comment '手机号',
    lrryid     varchar(50) null comment '录入人员ID',
    lrrymc     varchar(50) null comment '录入人员姓名',
    inserttime datetime    null comment '录入时间',
    deptid     varchar(50) null comment '部门id',
    deptname   varchar(50) null comment '部门名称'
)
    comment '保修负责人';

create table wywx_wbwxclry
(
    ID         varchar(32) not null,
    name       varchar(50) null comment '姓名',
    wxid       varchar(50) null comment '微信服务号OpenID，用于发送微信消息使用',
    wxuserid   varchar(50) null comment '微信企业号UserID，用于发送微信消息使用',
    phone      varchar(50) null comment '手机号',
    lrryid     varchar(50) null comment '录入人员ID',
    lrrymc     varchar(50) null comment '录入人员姓名',
    inserttime datetime    null comment '录入时间',
    deptid     varchar(50) null comment '部门id',
    deptname   varchar(50) null comment '部门名称'
)
    comment '保修人员';

create table wywx_wxgzh
(
    ID          varchar(32)  not null
        primary key,
    token       varchar(255) null comment '公众号TOKEN',
    appid       varchar(100) null comment '公众号APPID',
    appsecret   varchar(255) null comment '公众号APPSECRET',
    name        varchar(100) null comment '公众号名称',
    ysid        varchar(100) null comment '公众号原始ID',
    wxlogin     varchar(100) null comment '公众号登录帐号',
    wxpwd       varchar(100) null comment '公众号登录密码',
    mobile      varchar(50)  null comment '管理员手机号',
    email       varchar(100) null comment '管理员电子邮件',
    serverip    varchar(255) null comment '服务器IP',
    domain      varchar(255) null comment '服务器域名',
    serveruser  varchar(100) null comment '服务器操作系统远程登录用户名',
    serverpwd   varchar(100) null comment '服务器操作系统远程登录密码',
    pagetitle   varchar(100) null comment '微信端页面显示标题',
    validateurl varchar(255) null comment '回调验证url',
    bz          varchar(255) null comment '公众号描述',
    type        varchar(50)  null comment '公众号类别（1：服务号，2：企业号，3：订阅号）',
    lrryid      varchar(50)  null comment '录入人员ID',
    lrrymc      varchar(50)  null comment '录入人员姓名',
    inserttime  datetime     null comment '录入时间',
    updatetime  datetime     null comment '时间戳',
    deptid      varchar(50)  null comment '部门id',
    deptname    varchar(50)  null comment '部门名称',
    isdeleted   varchar(1)   null comment '删除标志（0：不删除，1：删除）'
)
    comment '微信服务号信息表';

create table wywx_wxmsg_log
(
    id         varchar(32) charset utf8mb4  not null comment '主键',
    type       varchar(50)                  null comment '类别(bx:报修)',
    clbs       varchar(50)                  null comment '处理标识（dp：派单，vw：查看，wx：维修处理，ev：评价，zb：转办维修处理）',
    xxid       varchar(50)                  null comment '提交信息ID（l例如：报修信息ID）',
    sendopenid varchar(100)                 null comment '发送人员openid',
    recvopenid varchar(100) charset utf8mb4 null comment '接收人员openid',
    msgmbid    varchar(100)                 null,
    msgmbmc    varchar(50)                  null comment '模版名称',
    msg        varchar(200) charset utf8mb4 null comment '消息内容',
    url        varchar(500) charset utf8mb4 null comment '处理业务url',
    sendstatus varchar(50)                  null comment '发送状态（1：成功，0：失败）',
    gzhdeptid  varchar(32) charset utf8mb4  null comment '公众号所在单位',
    inserttime datetime                     null comment '录入时间',
    constraint wywx_wxmsg_log_id
        unique (id)
)
    comment '发送微信消息日志表';

create index wywx_wxmsg_log_clbs
    on wywx_wxmsg_log (clbs);

create index wywx_wxmsg_log_gzhdeptid
    on wywx_wxmsg_log (gzhdeptid);

create index wywx_wxmsg_log_recvopenid
    on wywx_wxmsg_log (recvopenid);

create index wywx_wxmsg_log_sendopenid
    on wywx_wxmsg_log (sendopenid);

create index wywx_wxmsg_log_type
    on wywx_wxmsg_log (type);

create index wywx_wxmsg_log_xxid
    on wywx_wxmsg_log (xxid);

alter table wywx_wxmsg_log
    add primary key (id);

create table wywx_wxqyhmsg_log
(
    id         varchar(32) charset utf8mb4   not null comment '主键',
    type       varchar(50)                   null comment '类别(sbwb:设备维保)',
    clbs       varchar(50)                   null comment '处理标识（dp：派单，zb：转办，vw：查看，wx：维修完成，qr：确认完成）',
    xxtable    varchar(255)                  null comment '提交信息表名称',
    xxid       varchar(50)                   null comment '提交信息ID（例如：报修信息ID）',
    agentid    varchar(10)                   null comment '微信企业号应用ID（agentid）',
    agentname  varchar(50)                   null comment '微信企业号应用名称',
    sendopenid varchar(100)                  null comment '发送人员userid',
    recvopenid varchar(100) charset utf8mb4  null comment '接收人员userid',
    msgmbid    varchar(100)                  null,
    msgmbmc    varchar(50)                   null comment '模版名称',
    msg        varchar(2048) charset utf8mb4 null comment '消息内容',
    url        varchar(500) charset utf8mb4  null comment '处理业务url',
    sendstatus varchar(50)                   null comment '发送状态（1：成功，0：失败）',
    gzhdeptid  varchar(32) charset utf8mb4   null comment '公众号所在单位',
    inserttime datetime                      null comment '录入时间',
    constraint wywx_wxmsg_log_id
        unique (id)
);

create index wywx_wxmsg_log_clbs
    on wywx_wxqyhmsg_log (clbs);

create index wywx_wxmsg_log_gzhdeptid
    on wywx_wxqyhmsg_log (gzhdeptid);

create index wywx_wxmsg_log_inserttime
    on wywx_wxqyhmsg_log (inserttime);

create index wywx_wxmsg_log_recvopenid
    on wywx_wxqyhmsg_log (recvopenid);

create index wywx_wxmsg_log_sendopenid
    on wywx_wxqyhmsg_log (sendopenid);

create index wywx_wxmsg_log_sendstatus
    on wywx_wxqyhmsg_log (sendstatus);

create index wywx_wxmsg_log_type
    on wywx_wxqyhmsg_log (type);

create index wywx_wxmsg_log_xxid
    on wywx_wxqyhmsg_log (xxid);

alter table wywx_wxqyhmsg_log
    add primary key (id);


