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


