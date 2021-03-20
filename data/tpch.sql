CREATE TABLE `customer` (
  `c_custkey` bigint NOT NULL,
  `c_mktsegment` char(10) DEFAULT NULL,
  `c_nationkey` int DEFAULT NULL,
  `c_name` varchar(25) DEFAULT NULL,
  `c_address` varchar(40) DEFAULT NULL,
  `c_phone` char(15) DEFAULT NULL,
  `c_acctbal` decimal(19,4) DEFAULT NULL,
  `c_comment` varchar(118) DEFAULT NULL,
  PRIMARY KEY (`c_custkey`),
  KEY `c_nationkey` (`c_nationkey`),
  CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`c_nationkey`) REFERENCES `nation` (`n_nationkey`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8

CREATE TABLE `lineitem` (
  `l_shipdate` date DEFAULT NULL,
  `l_orderkey` bigint NOT NULL,
  `l_discount` decimal(19,4) NOT NULL,
  `l_extendedprice` decimal(19,4) NOT NULL,
  `l_suppkey` int NOT NULL,
  `l_quantity` bigint NOT NULL,
  `l_returnflag` char(1) DEFAULT NULL,
  `l_partkey` bigint NOT NULL,
  `l_linestatus` char(1) DEFAULT NULL,
  `l_tax` decimal(19,4) NOT NULL,
  `l_commitdate` date DEFAULT NULL,
  `l_receiptdate` date DEFAULT NULL,
  `l_shipmode` char(10) DEFAULT NULL,
  `l_linenumber` bigint NOT NULL,
  `l_shipinstruct` char(25) DEFAULT NULL,
  `l_comment` varchar(44) DEFAULT NULL,
  PRIMARY KEY (`l_orderkey`,`l_linenumber`),
  KEY `l_suppkey` (`l_suppkey`,`l_partkey`),
  KEY `l_partkey` (`l_partkey`,`l_suppkey`),
  CONSTRAINT `lineitem_ibfk_1` FOREIGN KEY (`l_orderkey`) REFERENCES `orders` (`o_orderkey`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `lineitem_ibfk_2` FOREIGN KEY (`l_partkey`, `l_suppkey`) REFERENCES `partsupp` (`ps_partkey`, `ps_suppkey`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8

CREATE TABLE `nation` (
  `n_nationkey` int NOT NULL,
  `n_name` char(25) DEFAULT NULL,
  `n_regionkey` int DEFAULT NULL,
  `n_comment` varchar(152) DEFAULT NULL,
  PRIMARY KEY (`n_nationkey`),
  KEY `n_regionkey` (`n_regionkey`),
  CONSTRAINT `nation_ibfk_1` FOREIGN KEY (`n_regionkey`) REFERENCES `region` (`r_regionkey`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8

CREATE TABLE `orders` (
  `o_orderdate` date DEFAULT NULL,
  `o_orderkey` bigint NOT NULL,
  `o_custkey` bigint NOT NULL,
  `o_orderpriority` char(15) DEFAULT NULL,
  `o_shippriority` int DEFAULT NULL,
  `o_clerk` char(15) DEFAULT NULL,
  `o_orderstatus` char(1) DEFAULT NULL,
  `o_totalprice` decimal(19,4) DEFAULT NULL,
  `o_comment` varchar(79) DEFAULT NULL,
  PRIMARY KEY (`o_orderkey`),
  KEY `o_custkey` (`o_custkey`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`o_custkey`) REFERENCES `customer` (`c_custkey`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8

CREATE TABLE `part` (
  `p_partkey` bigint NOT NULL,
  `p_type` varchar(25) DEFAULT NULL,
  `p_size` int DEFAULT NULL,
  `p_brand` char(10) DEFAULT NULL,
  `p_name` varchar(55) DEFAULT NULL,
  `p_container` char(10) DEFAULT NULL,
  `p_mfgr` char(25) DEFAULT NULL,
  `p_retailprice` decimal(19,4) DEFAULT NULL,
  `p_comment` varchar(23) DEFAULT NULL,
  PRIMARY KEY (`p_partkey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

CREATE TABLE `partsupp` (
  `ps_partkey` bigint NOT NULL,
  `ps_suppkey` int NOT NULL,
  `ps_supplycost` decimal(19,4) NOT NULL,
  `ps_availqty` int DEFAULT NULL,
  `ps_comment` varchar(199) DEFAULT NULL,
  PRIMARY KEY (`ps_partkey`,`ps_suppkey`),
  KEY `ps_suppkey` (`ps_suppkey`),
  CONSTRAINT `partsupp_ibfk_1` FOREIGN KEY (`ps_partkey`) REFERENCES `part` (`p_partkey`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `partsupp_ibfk_2` FOREIGN KEY (`ps_suppkey`) REFERENCES `supplier` (`s_suppkey`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8

CREATE TABLE `region` (
  `r_regionkey` int NOT NULL,
  `r_name` char(25) DEFAULT NULL,
  `r_comment` varchar(152) DEFAULT NULL,
  PRIMARY KEY (`r_regionkey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

CREATE TABLE `supplier` (
  `s_suppkey` int NOT NULL,
  `s_nationkey` int DEFAULT NULL,
  `s_comment` varchar(102) DEFAULT NULL,
  `s_name` char(25) DEFAULT NULL,
  `s_address` varchar(40) DEFAULT NULL,
  `s_phone` char(15) DEFAULT NULL,
  `s_acctbal` decimal(19,4) DEFAULT NULL,
  PRIMARY KEY (`s_suppkey`),
  KEY `supplier_ibfk_1` (`s_nationkey`),
  CONSTRAINT `supplier_ibfk_1` FOREIGN KEY (`s_nationkey`) REFERENCES `nation` (`n_nationkey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

