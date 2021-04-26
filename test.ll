@N = global i32 80, align 4

define void @___init__$$YGXXZ() {
entry:
	ret void
}

define i32 @_dceconst$$YGHXZ() {
entry:
	br label %for.cond

for.cond:
	%j_8 = phi i32 [ 0, %entry ], [ %j_7, %for.end ]
	%i_12 = phi i32 [ 0, %entry ], [ %postfix_inc_2, %for.end ]
	%b_2 = phi i32 [ 0, %entry ], [ %b, %for.end ]
	%a_2 = phi i32 [ 0, %entry ], [ %a, %for.end ]
	%c_7 = phi i32 [ 0, %entry ], [ %c_6, %for.end ]
	%N = load i32, i32* @N, align 4
	%slt = icmp slt i32 %i_12, %N
	br i1 %slt, label %for.body_2, label %for.end_2

for.cond_2:
	%j_7 = phi i32 [ 0, %for.body_2 ], [ %postfix_inc, %for.body ]
	%b = phi i32 [ %b_2, %for.body_2 ], [ %sub, %for.body ]
	%a = phi i32 [ %a_2, %for.body_2 ], [ %add, %for.body ]
	%c_6 = phi i32 [ %c_7, %for.body_2 ], [ %sdiv, %for.body ]
	%N_2 = load i32, i32* @N, align 4
	%slt_2 = icmp slt i32 %j_7, %N_2
	br i1 %slt_2, label %for.body, label %for.end

for.body:
	%add = add i32 %i_12, %j_7
	%sub = sub i32 %i_12, %j_7
	%add_2 = add i32 %i_12, %j_7
	%sub_2 = sub i32 %add_2, %i_12
	%mul = mul i32 %sub_2, %sub_2
	%N_3 = load i32, i32* @N, align 4
	%sdiv = sdiv i32 %mul, %N_3
	%postfix_inc = add i32 %j_7, 1
	br label %for.cond_2

for.end:
	%postfix_inc_2 = add i32 %i_12, 1
	br label %for.cond

for.body_2:
	br label %for.cond_2

for.end_2:
	br label %for.cond_3

for.cond_3:
	%i_11 = phi i32 [ 0, %for.end_2 ], [ %postfix_inc_3, %for.body_3 ]
	%N_4 = load i32, i32* @N, align 4
	%slt_3 = icmp slt i32 %i_11, %N_4
	br i1 %slt_3, label %for.body_3, label %for.end_3

for.body_3:
	%N_5 = load i32, i32* @N, align 4
	%add_35 = add i32 %N_5, 508104
	%add_36 = add i32 %add_35, 111
	%add_37 = add i32 %add_36, 0
	%add_38 = add i32 %add_37, 7
	%add_39 = add i32 %add_38, 0
	%add_40 = add i32 %add_39, 0
	%add_41 = add i32 %add_40, 7
	%add_42 = add i32 %add_41, 0
	%add_43 = add i32 %add_42, 0
	%add_44 = add i32 %add_43, 7
	%add_45 = add i32 %add_44, 0
	%xor_3 = xor i32 132, %add_45
	%xor_4 = xor i32 %xor_3, 12719578
	%xor_5 = xor i32 %xor_4, 12719578
	%xor_6 = xor i32 %xor_5, 12719578
	%xor_7 = xor i32 %xor_6, 12719578
	%xor_8 = xor i32 %xor_7, 12719578
	%xor_9 = xor i32 %xor_8, 12719578
	%xor_10 = xor i32 %xor_9, 12719578
	%xor_11 = xor i32 %xor_10, 12719578
	%xor_12 = xor i32 %xor_11, 12719578
	%xor_13 = xor i32 %xor_12, 12719578
	%xor_14 = xor i32 %xor_13, 12719578
	%xor_15 = xor i32 %xor_14, 12719578
	%xor_16 = xor i32 %xor_15, 12719578
	%xor_17 = xor i32 %xor_16, 12719578
	%xor_18 = xor i32 %xor_17, 12719578
	%xor_19 = xor i32 %xor_18, 12719578
	%xor_20 = xor i32 %xor_19, 12719578
	%xor_21 = xor i32 %xor_20, 12719578
	%xor_22 = xor i32 %xor_21, 12211342
	%add_244 = add i32 %xor_22, 11
	%postfix_inc_3 = add i32 %i_11, 1
	br label %for.cond_3

for.end_3:
	ret i32 114514
}

define i32 @_test$$YGHXZ() {
entry:
	br label %for.cond

for.cond:
	%j_6 = phi i32 [ 0, %entry ], [ %postfix_inc_2, %for.body ]
	%i_5 = phi i32 [ 0, %entry ], [ %postfix_inc_3, %for.body ]
	%slt = icmp slt i32 %i_5, 200
	br i1 %slt, label %for.body, label %for.end

for.body:
	%postfix_inc = add i32 %i_5, 1
	%postfix_inc_2 = add i32 %j_6, 1
	%postfix_inc_3 = add i32 %postfix_inc, 1
	br label %for.cond

for.end:
	ret i32 %j_6
}

define i32 @_naivedce$$YGHXZ() {
entry:
	br label %for.cond

for.cond:
	%sum_39 = phi i32 [ 0, %entry ], [ %add_490, %for.body ]
	%i_14 = phi i32 [ 1, %entry ], [ %postfix_inc, %for.body ]
	%sle = icmp sle i32 %i_14, 100
	br i1 %sle, label %for.body, label %for.end

for.body:
	%add_490 = add i32 %sum_39, %i_14
	%postfix_inc = add i32 %i_14, 1
	br label %for.cond

for.end:
	br label %for.cond_2

for.cond_2:
	%sum_38 = phi i32 [ %sum_39, %for.end ], [ %add_491, %for.body_2 ]
	%i_12 = phi i32 [ %i_14, %for.end ], [ %postfix_dec, %for.body_2 ]
	%sge = icmp sge i32 %i_12, 1
	br i1 %sge, label %for.body_2, label %for.end_2

for.body_2:
	%add_491 = add i32 %sum_38, %i_12
	%postfix_dec = sub i32 %i_12, 1
	br label %for.cond_2

for.end_2:
	%postfix_inc_2 = add i32 %i_12, 1
	br label %for.cond_3

for.cond_3:
	%prod_6 = phi i32 [ 1, %for.end_2 ], [ %mul_312, %for.body_3 ]
	%i_13 = phi i32 [ %postfix_inc_2, %for.end_2 ], [ %postfix_inc_3, %for.body_3 ]
	%sle_2 = icmp sle i32 %i_13, 10
	br i1 %sle_2, label %for.body_3, label %for.end_3

for.body_3:
	%mul_312 = mul i32 %prod_6, %i_13
	%postfix_inc_3 = add i32 %i_13, 1
	br label %for.cond_3

for.end_3:
	%eq_41 = icmp eq i32 %sum_38, 10100
	br i1 %eq_41, label %if.then_168, label %if.end_168

if.then_26:
	%postfix_inc_4 = add i32 %prod_6, 1
	br label %if.end_26

if.end_26:
	%prod_7 = phi i32 [ %postfix_inc_4, %if.then_26 ], [ %prod_6, %if.then_39 ]
	%dd_92 = phi i32 [ -99997, %if.then_26 ], [ -99996, %if.then_39 ]
	br label %if.end_39

if.then_39:
	%eq_179 = icmp eq i32 %prod_6, 3628800
	br i1 %eq_179, label %if.then_26, label %if.end_26

if.end_39:
	%prod_20 = phi i32 [ %prod_7, %if.end_26 ], [ %prod_6, %if.then_76 ]
	%dd_105 = phi i32 [ %dd_92, %if.end_26 ], [ -99996, %if.then_76 ]
	br label %if.end_76

if.then_76:
	%eq_166 = icmp eq i32 %sum_38, 10100
	br i1 %eq_166, label %if.then_39, label %if.end_39

if.end_76:
	%prod_57 = phi i32 [ %prod_20, %if.end_39 ], [ %prod_6, %if.then_113 ]
	%dd_142 = phi i32 [ %dd_105, %if.end_39 ], [ -99996, %if.then_113 ]
	br label %if.end_113

if.then_113:
	%eq_129 = icmp eq i32 %prod_6, 3628800
	br i1 %eq_129, label %if.then_76, label %if.end_76

if.end_113:
	%prod_94 = phi i32 [ %prod_57, %if.end_76 ], [ %prod_6, %if.then_114 ]
	%dd_179 = phi i32 [ %dd_142, %if.end_76 ], [ -99996, %if.then_114 ]
	br label %if.end_114

if.then_114:
	%eq_92 = icmp eq i32 %sum_38, 10100
	br i1 %eq_92, label %if.then_113, label %if.end_113

if.end_114:
	%prod_95 = phi i32 [ %prod_94, %if.end_113 ], [ %prod_6, %if.then_115 ]
	%dd_180 = phi i32 [ %dd_179, %if.end_113 ], [ -99996, %if.then_115 ]
	br label %if.end_115

if.then_115:
	%eq_91 = icmp eq i32 %sum_38, 10100
	br i1 %eq_91, label %if.then_114, label %if.end_114

if.end_115:
	%prod_96 = phi i32 [ %prod_95, %if.end_114 ], [ %prod_6, %if.then_116 ]
	%dd_181 = phi i32 [ %dd_180, %if.end_114 ], [ -99996, %if.then_116 ]
	br label %if.end_116

if.then_116:
	%eq_90 = icmp eq i32 %sum_38, 10100
	br i1 %eq_90, label %if.then_115, label %if.end_115

if.end_116:
	%prod_97 = phi i32 [ %prod_96, %if.end_115 ], [ %prod_6, %if.then_117 ]
	%dd_182 = phi i32 [ %dd_181, %if.end_115 ], [ -99996, %if.then_117 ]
	br label %if.end_117

if.then_117:
	%eq_89 = icmp eq i32 %sum_38, 10100
	br i1 %eq_89, label %if.then_116, label %if.end_116

if.end_117:
	%prod_98 = phi i32 [ %prod_97, %if.end_116 ], [ %prod_6, %if.then_118 ]
	%dd_183 = phi i32 [ %dd_182, %if.end_116 ], [ -99996, %if.then_118 ]
	br label %if.end_118

if.then_118:
	%eq_88 = icmp eq i32 %sum_38, 10100
	br i1 %eq_88, label %if.then_117, label %if.end_117

if.end_118:
	%prod_99 = phi i32 [ %prod_98, %if.end_117 ], [ %prod_6, %if.then_119 ]
	%dd_184 = phi i32 [ %dd_183, %if.end_117 ], [ -99996, %if.then_119 ]
	br label %if.end_119

if.then_119:
	%eq_87 = icmp eq i32 %sum_38, 10100
	br i1 %eq_87, label %if.then_118, label %if.end_118

if.end_119:
	%prod_100 = phi i32 [ %prod_99, %if.end_118 ], [ %prod_6, %if.then_120 ]
	%dd_185 = phi i32 [ %dd_184, %if.end_118 ], [ -99996, %if.then_120 ]
	br label %if.end_120

if.then_120:
	%eq_86 = icmp eq i32 %sum_38, 10100
	br i1 %eq_86, label %if.then_119, label %if.end_119

if.end_120:
	%prod_101 = phi i32 [ %prod_100, %if.end_119 ], [ %prod_6, %if.then_121 ]
	%dd_186 = phi i32 [ %dd_185, %if.end_119 ], [ -99996, %if.then_121 ]
	br label %if.end_121

if.then_121:
	%eq_85 = icmp eq i32 %sum_38, 10100
	br i1 %eq_85, label %if.then_120, label %if.end_120

if.end_121:
	%prod_102 = phi i32 [ %prod_101, %if.end_120 ], [ %prod_6, %if.then_122 ]
	%dd_187 = phi i32 [ %dd_186, %if.end_120 ], [ -99996, %if.then_122 ]
	br label %if.end_122

if.then_122:
	%eq_84 = icmp eq i32 %sum_38, 10100
	br i1 %eq_84, label %if.then_121, label %if.end_121

if.end_122:
	%prod_103 = phi i32 [ %prod_102, %if.end_121 ], [ %prod_6, %if.then_123 ]
	%dd_188 = phi i32 [ %dd_187, %if.end_121 ], [ -99996, %if.then_123 ]
	br label %if.end_123

if.then_123:
	%eq_83 = icmp eq i32 %sum_38, 10100
	br i1 %eq_83, label %if.then_122, label %if.end_122

if.end_123:
	%prod_104 = phi i32 [ %prod_103, %if.end_122 ], [ %prod_6, %if.then_124 ]
	%dd_189 = phi i32 [ %dd_188, %if.end_122 ], [ -99996, %if.then_124 ]
	br label %if.end_124

if.then_124:
	%eq_82 = icmp eq i32 %sum_38, 10100
	br i1 %eq_82, label %if.then_123, label %if.end_123

if.end_124:
	%prod_105 = phi i32 [ %prod_104, %if.end_123 ], [ %prod_6, %if.then_125 ]
	%dd_190 = phi i32 [ %dd_189, %if.end_123 ], [ -99996, %if.then_125 ]
	br label %if.end_125

if.then_125:
	%eq_81 = icmp eq i32 %sum_38, 10100
	br i1 %eq_81, label %if.then_124, label %if.end_124

if.end_125:
	%prod_106 = phi i32 [ %prod_105, %if.end_124 ], [ %prod_6, %if.then_126 ]
	%dd_191 = phi i32 [ %dd_190, %if.end_124 ], [ -99996, %if.then_126 ]
	br label %if.end_126

if.then_126:
	%eq_80 = icmp eq i32 %sum_38, 10100
	br i1 %eq_80, label %if.then_125, label %if.end_125

if.end_126:
	%prod_107 = phi i32 [ %prod_106, %if.end_125 ], [ %prod_6, %if.then_127 ]
	%dd_192 = phi i32 [ %dd_191, %if.end_125 ], [ -99996, %if.then_127 ]
	br label %if.end_127

if.then_127:
	%eq_79 = icmp eq i32 %sum_38, 10100
	br i1 %eq_79, label %if.then_126, label %if.end_126

if.end_127:
	%prod_108 = phi i32 [ %prod_107, %if.end_126 ], [ %prod_6, %if.then_128 ]
	%dd_193 = phi i32 [ %dd_192, %if.end_126 ], [ -99996, %if.then_128 ]
	br label %if.end_128

if.then_128:
	%eq_78 = icmp eq i32 %sum_38, 10100
	br i1 %eq_78, label %if.then_127, label %if.end_127

if.end_128:
	%prod_109 = phi i32 [ %prod_108, %if.end_127 ], [ %prod_6, %if.then_129 ]
	%dd_194 = phi i32 [ %dd_193, %if.end_127 ], [ -99996, %if.then_129 ]
	br label %if.end_129

if.then_129:
	%eq_77 = icmp eq i32 %sum_38, 10100
	br i1 %eq_77, label %if.then_128, label %if.end_128

if.end_129:
	%prod_110 = phi i32 [ %prod_109, %if.end_128 ], [ %prod_6, %if.then_130 ]
	%dd_195 = phi i32 [ %dd_194, %if.end_128 ], [ -99996, %if.then_130 ]
	br label %if.end_130

if.then_130:
	%eq_76 = icmp eq i32 %sum_38, 10100
	br i1 %eq_76, label %if.then_129, label %if.end_129

if.end_130:
	%prod_111 = phi i32 [ %prod_110, %if.end_129 ], [ %prod_6, %if.then_131 ]
	%dd_196 = phi i32 [ %dd_195, %if.end_129 ], [ -99996, %if.then_131 ]
	br label %if.end_131

if.then_131:
	%eq_75 = icmp eq i32 %sum_38, 10100
	br i1 %eq_75, label %if.then_130, label %if.end_130

if.end_131:
	%prod_112 = phi i32 [ %prod_111, %if.end_130 ], [ %prod_6, %if.then_132 ]
	%dd_197 = phi i32 [ %dd_196, %if.end_130 ], [ -99996, %if.then_132 ]
	br label %if.end_132

if.then_132:
	%eq_74 = icmp eq i32 %sum_38, 10100
	br i1 %eq_74, label %if.then_131, label %if.end_131

if.end_132:
	%prod_113 = phi i32 [ %prod_112, %if.end_131 ], [ %prod_6, %if.then_133 ]
	%dd_198 = phi i32 [ %dd_197, %if.end_131 ], [ -99996, %if.then_133 ]
	br label %if.end_133

if.then_133:
	%eq_73 = icmp eq i32 %sum_38, 10100
	br i1 %eq_73, label %if.then_132, label %if.end_132

if.end_133:
	%prod_114 = phi i32 [ %prod_113, %if.end_132 ], [ %prod_6, %if.then_134 ]
	%dd_199 = phi i32 [ %dd_198, %if.end_132 ], [ -99996, %if.then_134 ]
	br label %if.end_134

if.then_134:
	%eq_72 = icmp eq i32 %sum_38, 10100
	br i1 %eq_72, label %if.then_133, label %if.end_133

if.end_134:
	%prod_115 = phi i32 [ %prod_114, %if.end_133 ], [ %prod_6, %if.then_135 ]
	%dd_200 = phi i32 [ %dd_199, %if.end_133 ], [ -99996, %if.then_135 ]
	br label %if.end_135

if.then_135:
	%eq_71 = icmp eq i32 %sum_38, 10100
	br i1 %eq_71, label %if.then_134, label %if.end_134

if.end_135:
	%prod_116 = phi i32 [ %prod_115, %if.end_134 ], [ %prod_6, %if.then_136 ]
	%dd_201 = phi i32 [ %dd_200, %if.end_134 ], [ -99996, %if.then_136 ]
	br label %if.end_136

if.then_136:
	%eq_70 = icmp eq i32 %sum_38, 10100
	br i1 %eq_70, label %if.then_135, label %if.end_135

if.end_136:
	%prod_117 = phi i32 [ %prod_116, %if.end_135 ], [ %prod_6, %if.then_161 ]
	%dd_202 = phi i32 [ %dd_201, %if.end_135 ], [ -99996, %if.then_161 ]
	br label %if.end_161

if.then_161:
	%eq_69 = icmp eq i32 %sum_38, 10100
	br i1 %eq_69, label %if.then_136, label %if.end_136

if.end_161:
	%prod_142 = phi i32 [ %prod_117, %if.end_136 ], [ %prod_6, %if.then_162 ]
	%dd_227 = phi i32 [ %dd_202, %if.end_136 ], [ -99996, %if.then_162 ]
	br label %if.end_162

if.then_162:
	%eq_48 = icmp eq i32 %sum_38, 10100
	br i1 %eq_48, label %if.then_161, label %if.end_161

if.end_162:
	%prod_143 = phi i32 [ %prod_142, %if.end_161 ], [ %prod_6, %if.then_163 ]
	%dd_228 = phi i32 [ %dd_227, %if.end_161 ], [ -99996, %if.then_163 ]
	br label %if.end_163

if.then_163:
	%eq_47 = icmp eq i32 %sum_38, 10100
	br i1 %eq_47, label %if.then_162, label %if.end_162

if.end_163:
	%prod_144 = phi i32 [ %prod_143, %if.end_162 ], [ %prod_6, %if.then_164 ]
	%dd_229 = phi i32 [ %dd_228, %if.end_162 ], [ -99996, %if.then_164 ]
	br label %if.end_164

if.then_164:
	%eq_46 = icmp eq i32 %sum_38, 10100
	br i1 %eq_46, label %if.then_163, label %if.end_163

if.end_164:
	%prod_145 = phi i32 [ %prod_144, %if.end_163 ], [ %prod_6, %if.then_165 ]
	%dd_230 = phi i32 [ %dd_229, %if.end_163 ], [ -99996, %if.then_165 ]
	br label %if.end_165

if.then_165:
	%eq_45 = icmp eq i32 %sum_38, 10100
	br i1 %eq_45, label %if.then_164, label %if.end_164

if.end_165:
	%prod_146 = phi i32 [ %prod_145, %if.end_164 ], [ %prod_6, %if.then_166 ]
	%dd_231 = phi i32 [ %dd_230, %if.end_164 ], [ -99996, %if.then_166 ]
	br label %if.end_166

if.then_166:
	%eq_44 = icmp eq i32 %sum_38, 10100
	br i1 %eq_44, label %if.then_165, label %if.end_165

if.end_166:
	%prod_147 = phi i32 [ %prod_146, %if.end_165 ], [ %prod_6, %if.then_167 ]
	%dd_232 = phi i32 [ %dd_231, %if.end_165 ], [ -99996, %if.then_167 ]
	br label %if.end_167

if.then_167:
	%eq_43 = icmp eq i32 %sum_38, 10100
	br i1 %eq_43, label %if.then_166, label %if.end_166

if.end_167:
	%prod_148 = phi i32 [ %prod_147, %if.end_166 ], [ %prod_6, %if.then_168 ]
	%dd_233 = phi i32 [ %dd_232, %if.end_166 ], [ -99996, %if.then_168 ]
	br label %if.end_168

if.then_168:
	%eq_42 = icmp eq i32 %sum_38, 10100
	br i1 %eq_42, label %if.then_167, label %if.end_167

if.end_168:
	%prod_149 = phi i32 [ %prod_148, %if.end_167 ], [ %prod_6, %for.end_3 ]
	%dd_234 = phi i32 [ %dd_233, %if.end_167 ], [ -99996, %for.end_3 ]
	ret i32 1919
}

define i32 @main() {
entry:
	call void @___init__$$YGXXZ()
	%funcCallRet = call i32 @_test$$YGHXZ()
	%funcCallRet_2 = call i32 @_naivedce$$YGHXZ()
	%add = add i32 %funcCallRet, %funcCallRet_2
	%funcCallRet_3 = call i32 @_dceconst$$YGHXZ()
	%add_2 = add i32 %add, %funcCallRet_3
	%sub = sub i32 %add_2, 50997
	ret i32 %sub
}

declare i32 @_length$string$$QEAHXZ(i8* %str)

declare i32 @_ord$string$$QEAHH$Z(i8* %str, i32 %pos)

declare i8* @_strcat$$YGPADPADPAD$Z(i8* %str1, i8* %str2)

declare i32 @_parseInt$string$$QEAHXZ(i8* %str)

declare void @_printInt$$YGXH$Z(i32 %n)

declare i1 @_strcmp_le$$YG_NPADPAD$Z(i8* %str1, i8* %str2)

declare i8* @_malloc$$YGPADH$Z(i32 %size)

declare i1 @_strcmp_ge$$YG_NPADPAD$Z(i8* %str1, i8* %str2)

declare i1 @_strcmp_lt$$YG_NPADPAD$Z(i8* %str1, i8* %str2)

declare i8* @_getString$$YGPADXZ()

declare i1 @_strcmp_eq$$YG_NPADPAD$Z(i8* %str1, i8* %str2)

declare i32 @_getInt$$YGHXZ()

declare void @_print$$YGXPAD$Z(i8* %str)

declare i1 @_strcmp_neq$$YG_NPADPAD$Z(i8* %str1, i8* %str2)

declare i8* @_substring$string$$QEAPADHH$Z(i8* %str, i32 %left, i32 %right)

declare i1 @_strcmp_gt$$YG_NPADPAD$Z(i8* %str1, i8* %str2)

declare void @_println$$YGXPAD$Z(i8* %str)

declare void @_printlnInt$$YGXH$Z(i32 %n)

declare i8* @_toString$$YGPADH$Z(i32 %i)

