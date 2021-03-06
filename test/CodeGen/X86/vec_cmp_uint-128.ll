; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse2 | FileCheck %s --check-prefix=ALL --check-prefix=SSE --check-prefix=SSE2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse4.1 | FileCheck %s --check-prefix=ALL --check-prefix=SSE --check-prefix=SSE41
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse4.2 | FileCheck %s --check-prefix=ALL --check-prefix=SSE --check-prefix=SSE42
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx | FileCheck %s --check-prefix=ALL --check-prefix=AVX --check-prefix=AVX1
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx2 | FileCheck %s --check-prefix=ALL --check-prefix=AVX --check-prefix=AVX2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx,+xop | FileCheck %s --check-prefix=ALL --check-prefix=XOP --check-prefix=XOPAVX1
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx2,+xop | FileCheck %s --check-prefix=ALL --check-prefix=XOP --check-prefix=XOPAVX2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512f | FileCheck %s --check-prefix=ALL --check-prefix=AVX --check-prefix=AVX512 --check-prefix=AVX512F
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512bw | FileCheck %s --check-prefix=ALL --check-prefix=AVX --check-prefix=AVX512 --check-prefix=AVX512BW

;
; Equal
;

define <2 x i64> @eq_v2i64(<2 x i64> %a, <2 x i64> %b) nounwind {
; SSE2-LABEL: eq_v2i64:
; SSE2:       # BB#0:
; SSE2-NEXT:    pcmpeqd %xmm1, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[1,0,3,2]
; SSE2-NEXT:    pand %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: eq_v2i64:
; SSE41:       # BB#0:
; SSE41-NEXT:    pcmpeqq %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; SSE42-LABEL: eq_v2i64:
; SSE42:       # BB#0:
; SSE42-NEXT:    pcmpeqq %xmm1, %xmm0
; SSE42-NEXT:    retq
;
; AVX-LABEL: eq_v2i64:
; AVX:       # BB#0:
; AVX-NEXT:    vpcmpeqq %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
;
; XOP-LABEL: eq_v2i64:
; XOP:       # BB#0:
; XOP-NEXT:    vpcomeqq %xmm1, %xmm0, %xmm0
; XOP-NEXT:    retq
  %1 = icmp eq <2 x i64> %a, %b
  %2 = sext <2 x i1> %1 to <2 x i64>
  ret <2 x i64> %2
}

define <4 x i32> @eq_v4i32(<4 x i32> %a, <4 x i32> %b) nounwind {
; SSE-LABEL: eq_v4i32:
; SSE:       # BB#0:
; SSE-NEXT:    pcmpeqd %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: eq_v4i32:
; AVX:       # BB#0:
; AVX-NEXT:    vpcmpeqd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
;
; XOP-LABEL: eq_v4i32:
; XOP:       # BB#0:
; XOP-NEXT:    vpcomeqd %xmm1, %xmm0, %xmm0
; XOP-NEXT:    retq
  %1 = icmp eq <4 x i32> %a, %b
  %2 = sext <4 x i1> %1 to <4 x i32>
  ret <4 x i32> %2
}

define <8 x i16> @eq_v8i16(<8 x i16> %a, <8 x i16> %b) nounwind {
; SSE-LABEL: eq_v8i16:
; SSE:       # BB#0:
; SSE-NEXT:    pcmpeqw %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: eq_v8i16:
; AVX:       # BB#0:
; AVX-NEXT:    vpcmpeqw %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
;
; XOP-LABEL: eq_v8i16:
; XOP:       # BB#0:
; XOP-NEXT:    vpcomeqw %xmm1, %xmm0, %xmm0
; XOP-NEXT:    retq
  %1 = icmp eq <8 x i16> %a, %b
  %2 = sext <8 x i1> %1 to <8 x i16>
  ret <8 x i16> %2
}

define <16 x i8> @eq_v16i8(<16 x i8> %a, <16 x i8> %b) nounwind {
; SSE-LABEL: eq_v16i8:
; SSE:       # BB#0:
; SSE-NEXT:    pcmpeqb %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: eq_v16i8:
; AVX:       # BB#0:
; AVX-NEXT:    vpcmpeqb %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
;
; XOP-LABEL: eq_v16i8:
; XOP:       # BB#0:
; XOP-NEXT:    vpcomeqb %xmm1, %xmm0, %xmm0
; XOP-NEXT:    retq
  %1 = icmp eq <16 x i8> %a, %b
  %2 = sext <16 x i1> %1 to <16 x i8>
  ret <16 x i8> %2
}

;
; Not Equal
;

define <2 x i64> @ne_v2i64(<2 x i64> %a, <2 x i64> %b) nounwind {
; SSE2-LABEL: ne_v2i64:
; SSE2:       # BB#0:
; SSE2-NEXT:    pcmpeqd %xmm1, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[1,0,3,2]
; SSE2-NEXT:    pand %xmm1, %xmm0
; SSE2-NEXT:    pcmpeqd %xmm1, %xmm1
; SSE2-NEXT:    pxor %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: ne_v2i64:
; SSE41:       # BB#0:
; SSE41-NEXT:    pcmpeqq %xmm1, %xmm0
; SSE41-NEXT:    pcmpeqd %xmm1, %xmm1
; SSE41-NEXT:    pxor %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; SSE42-LABEL: ne_v2i64:
; SSE42:       # BB#0:
; SSE42-NEXT:    pcmpeqq %xmm1, %xmm0
; SSE42-NEXT:    pcmpeqd %xmm1, %xmm1
; SSE42-NEXT:    pxor %xmm1, %xmm0
; SSE42-NEXT:    retq
;
; AVX-LABEL: ne_v2i64:
; AVX:       # BB#0:
; AVX-NEXT:    vpcmpeqq %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpcmpeqd %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vpxor %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
;
; XOP-LABEL: ne_v2i64:
; XOP:       # BB#0:
; XOP-NEXT:    vpcomneqq %xmm1, %xmm0, %xmm0
; XOP-NEXT:    retq
  %1 = icmp ne <2 x i64> %a, %b
  %2 = sext <2 x i1> %1 to <2 x i64>
  ret <2 x i64> %2
}

define <4 x i32> @ne_v4i32(<4 x i32> %a, <4 x i32> %b) nounwind {
; SSE-LABEL: ne_v4i32:
; SSE:       # BB#0:
; SSE-NEXT:    pcmpeqd %xmm1, %xmm0
; SSE-NEXT:    pcmpeqd %xmm1, %xmm1
; SSE-NEXT:    pxor %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: ne_v4i32:
; AVX:       # BB#0:
; AVX-NEXT:    vpcmpeqd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpcmpeqd %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vpxor %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
;
; XOP-LABEL: ne_v4i32:
; XOP:       # BB#0:
; XOP-NEXT:    vpcomneqd %xmm1, %xmm0, %xmm0
; XOP-NEXT:    retq
  %1 = icmp ne <4 x i32> %a, %b
  %2 = sext <4 x i1> %1 to <4 x i32>
  ret <4 x i32> %2
}

define <8 x i16> @ne_v8i16(<8 x i16> %a, <8 x i16> %b) nounwind {
; SSE-LABEL: ne_v8i16:
; SSE:       # BB#0:
; SSE-NEXT:    pcmpeqw %xmm1, %xmm0
; SSE-NEXT:    pcmpeqd %xmm1, %xmm1
; SSE-NEXT:    pxor %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: ne_v8i16:
; AVX:       # BB#0:
; AVX-NEXT:    vpcmpeqw %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpcmpeqd %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vpxor %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
;
; XOP-LABEL: ne_v8i16:
; XOP:       # BB#0:
; XOP-NEXT:    vpcomneqw %xmm1, %xmm0, %xmm0
; XOP-NEXT:    retq
  %1 = icmp ne <8 x i16> %a, %b
  %2 = sext <8 x i1> %1 to <8 x i16>
  ret <8 x i16> %2
}

define <16 x i8> @ne_v16i8(<16 x i8> %a, <16 x i8> %b) nounwind {
; SSE-LABEL: ne_v16i8:
; SSE:       # BB#0:
; SSE-NEXT:    pcmpeqb %xmm1, %xmm0
; SSE-NEXT:    pcmpeqd %xmm1, %xmm1
; SSE-NEXT:    pxor %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: ne_v16i8:
; AVX:       # BB#0:
; AVX-NEXT:    vpcmpeqb %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpcmpeqd %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vpxor %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
;
; XOP-LABEL: ne_v16i8:
; XOP:       # BB#0:
; XOP-NEXT:    vpcomneqb %xmm1, %xmm0, %xmm0
; XOP-NEXT:    retq
  %1 = icmp ne <16 x i8> %a, %b
  %2 = sext <16 x i1> %1 to <16 x i8>
  ret <16 x i8> %2
}

;
; Greater Than Or Equal
;

define <2 x i64> @ge_v2i64(<2 x i64> %a, <2 x i64> %b) nounwind {
; SSE2-LABEL: ge_v2i64:
; SSE2:       # BB#0:
; SSE2-NEXT:    movdqa {{.*#+}} xmm2 = [2147483648,2147483648,2147483648,2147483648]
; SSE2-NEXT:    pxor %xmm2, %xmm0
; SSE2-NEXT:    pxor %xmm2, %xmm1
; SSE2-NEXT:    movdqa %xmm1, %xmm2
; SSE2-NEXT:    pcmpgtd %xmm0, %xmm2
; SSE2-NEXT:    pshufd {{.*#+}} xmm3 = xmm2[0,0,2,2]
; SSE2-NEXT:    pcmpeqd %xmm0, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[1,1,3,3]
; SSE2-NEXT:    pand %xmm3, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm2[1,1,3,3]
; SSE2-NEXT:    por %xmm0, %xmm1
; SSE2-NEXT:    pcmpeqd %xmm0, %xmm0
; SSE2-NEXT:    pxor %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: ge_v2i64:
; SSE41:       # BB#0:
; SSE41-NEXT:    movdqa {{.*#+}} xmm2 = [2147483648,2147483648,2147483648,2147483648]
; SSE41-NEXT:    pxor %xmm2, %xmm0
; SSE41-NEXT:    pxor %xmm2, %xmm1
; SSE41-NEXT:    movdqa %xmm1, %xmm2
; SSE41-NEXT:    pcmpgtd %xmm0, %xmm2
; SSE41-NEXT:    pshufd {{.*#+}} xmm3 = xmm2[0,0,2,2]
; SSE41-NEXT:    pcmpeqd %xmm0, %xmm1
; SSE41-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[1,1,3,3]
; SSE41-NEXT:    pand %xmm3, %xmm0
; SSE41-NEXT:    pshufd {{.*#+}} xmm1 = xmm2[1,1,3,3]
; SSE41-NEXT:    por %xmm0, %xmm1
; SSE41-NEXT:    pcmpeqd %xmm0, %xmm0
; SSE41-NEXT:    pxor %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; SSE42-LABEL: ge_v2i64:
; SSE42:       # BB#0:
; SSE42-NEXT:    movdqa {{.*#+}} xmm2 = [9223372036854775808,9223372036854775808]
; SSE42-NEXT:    pxor %xmm2, %xmm0
; SSE42-NEXT:    pxor %xmm1, %xmm2
; SSE42-NEXT:    pcmpgtq %xmm0, %xmm2
; SSE42-NEXT:    pcmpeqd %xmm0, %xmm0
; SSE42-NEXT:    pxor %xmm2, %xmm0
; SSE42-NEXT:    retq
;
; AVX-LABEL: ge_v2i64:
; AVX:       # BB#0:
; AVX-NEXT:    vmovdqa {{.*#+}} xmm2 = [9223372036854775808,9223372036854775808]
; AVX-NEXT:    vpxor %xmm2, %xmm0, %xmm0
; AVX-NEXT:    vpxor %xmm2, %xmm1, %xmm1
; AVX-NEXT:    vpcmpgtq %xmm0, %xmm1, %xmm0
; AVX-NEXT:    vpcmpeqd %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vpxor %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
;
; XOP-LABEL: ge_v2i64:
; XOP:       # BB#0:
; XOP-NEXT:    vpcomgeuq %xmm1, %xmm0, %xmm0
; XOP-NEXT:    retq
  %1 = icmp uge <2 x i64> %a, %b
  %2 = sext <2 x i1> %1 to <2 x i64>
  ret <2 x i64> %2
}

define <4 x i32> @ge_v4i32(<4 x i32> %a, <4 x i32> %b) nounwind {
; SSE2-LABEL: ge_v4i32:
; SSE2:       # BB#0:
; SSE2-NEXT:    movdqa {{.*#+}} xmm2 = [2147483648,2147483648,2147483648,2147483648]
; SSE2-NEXT:    pxor %xmm2, %xmm0
; SSE2-NEXT:    pxor %xmm1, %xmm2
; SSE2-NEXT:    pcmpgtd %xmm0, %xmm2
; SSE2-NEXT:    pcmpeqd %xmm0, %xmm0
; SSE2-NEXT:    pxor %xmm2, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: ge_v4i32:
; SSE41:       # BB#0:
; SSE41-NEXT:    pmaxud %xmm0, %xmm1
; SSE41-NEXT:    pcmpeqd %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; SSE42-LABEL: ge_v4i32:
; SSE42:       # BB#0:
; SSE42-NEXT:    pmaxud %xmm0, %xmm1
; SSE42-NEXT:    pcmpeqd %xmm1, %xmm0
; SSE42-NEXT:    retq
;
; AVX-LABEL: ge_v4i32:
; AVX:       # BB#0:
; AVX-NEXT:    vpmaxud %xmm1, %xmm0, %xmm1
; AVX-NEXT:    vpcmpeqd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
;
; XOP-LABEL: ge_v4i32:
; XOP:       # BB#0:
; XOP-NEXT:    vpcomgeud %xmm1, %xmm0, %xmm0
; XOP-NEXT:    retq
  %1 = icmp uge <4 x i32> %a, %b
  %2 = sext <4 x i1> %1 to <4 x i32>
  ret <4 x i32> %2
}

define <8 x i16> @ge_v8i16(<8 x i16> %a, <8 x i16> %b) nounwind {
; SSE2-LABEL: ge_v8i16:
; SSE2:       # BB#0:
; SSE2-NEXT:    psubusw %xmm0, %xmm1
; SSE2-NEXT:    pxor %xmm0, %xmm0
; SSE2-NEXT:    pcmpeqw %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: ge_v8i16:
; SSE41:       # BB#0:
; SSE41-NEXT:    pmaxuw %xmm0, %xmm1
; SSE41-NEXT:    pcmpeqw %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; SSE42-LABEL: ge_v8i16:
; SSE42:       # BB#0:
; SSE42-NEXT:    pmaxuw %xmm0, %xmm1
; SSE42-NEXT:    pcmpeqw %xmm1, %xmm0
; SSE42-NEXT:    retq
;
; AVX-LABEL: ge_v8i16:
; AVX:       # BB#0:
; AVX-NEXT:    vpmaxuw %xmm1, %xmm0, %xmm1
; AVX-NEXT:    vpcmpeqw %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
;
; XOP-LABEL: ge_v8i16:
; XOP:       # BB#0:
; XOP-NEXT:    vpcomgeuw %xmm1, %xmm0, %xmm0
; XOP-NEXT:    retq
  %1 = icmp uge <8 x i16> %a, %b
  %2 = sext <8 x i1> %1 to <8 x i16>
  ret <8 x i16> %2
}

define <16 x i8> @ge_v16i8(<16 x i8> %a, <16 x i8> %b) nounwind {
; SSE-LABEL: ge_v16i8:
; SSE:       # BB#0:
; SSE-NEXT:    pmaxub %xmm0, %xmm1
; SSE-NEXT:    pcmpeqb %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: ge_v16i8:
; AVX:       # BB#0:
; AVX-NEXT:    vpmaxub %xmm1, %xmm0, %xmm1
; AVX-NEXT:    vpcmpeqb %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
;
; XOP-LABEL: ge_v16i8:
; XOP:       # BB#0:
; XOP-NEXT:    vpcomgeub %xmm1, %xmm0, %xmm0
; XOP-NEXT:    retq
  %1 = icmp uge <16 x i8> %a, %b
  %2 = sext <16 x i1> %1 to <16 x i8>
  ret <16 x i8> %2
}

;
; Greater Than
;

define <2 x i64> @gt_v2i64(<2 x i64> %a, <2 x i64> %b) nounwind {
; SSE2-LABEL: gt_v2i64:
; SSE2:       # BB#0:
; SSE2-NEXT:    movdqa {{.*#+}} xmm2 = [2147483648,2147483648,2147483648,2147483648]
; SSE2-NEXT:    pxor %xmm2, %xmm1
; SSE2-NEXT:    pxor %xmm2, %xmm0
; SSE2-NEXT:    movdqa %xmm0, %xmm2
; SSE2-NEXT:    pcmpgtd %xmm1, %xmm2
; SSE2-NEXT:    pshufd {{.*#+}} xmm3 = xmm2[0,0,2,2]
; SSE2-NEXT:    pcmpeqd %xmm1, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[1,1,3,3]
; SSE2-NEXT:    pand %xmm3, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm2[1,1,3,3]
; SSE2-NEXT:    por %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: gt_v2i64:
; SSE41:       # BB#0:
; SSE41-NEXT:    movdqa {{.*#+}} xmm2 = [2147483648,2147483648,2147483648,2147483648]
; SSE41-NEXT:    pxor %xmm2, %xmm1
; SSE41-NEXT:    pxor %xmm2, %xmm0
; SSE41-NEXT:    movdqa %xmm0, %xmm2
; SSE41-NEXT:    pcmpgtd %xmm1, %xmm2
; SSE41-NEXT:    pshufd {{.*#+}} xmm3 = xmm2[0,0,2,2]
; SSE41-NEXT:    pcmpeqd %xmm1, %xmm0
; SSE41-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[1,1,3,3]
; SSE41-NEXT:    pand %xmm3, %xmm1
; SSE41-NEXT:    pshufd {{.*#+}} xmm0 = xmm2[1,1,3,3]
; SSE41-NEXT:    por %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; SSE42-LABEL: gt_v2i64:
; SSE42:       # BB#0:
; SSE42-NEXT:    movdqa {{.*#+}} xmm2 = [9223372036854775808,9223372036854775808]
; SSE42-NEXT:    pxor %xmm2, %xmm1
; SSE42-NEXT:    pxor %xmm2, %xmm0
; SSE42-NEXT:    pcmpgtq %xmm1, %xmm0
; SSE42-NEXT:    retq
;
; AVX-LABEL: gt_v2i64:
; AVX:       # BB#0:
; AVX-NEXT:    vmovdqa {{.*#+}} xmm2 = [9223372036854775808,9223372036854775808]
; AVX-NEXT:    vpxor %xmm2, %xmm1, %xmm1
; AVX-NEXT:    vpxor %xmm2, %xmm0, %xmm0
; AVX-NEXT:    vpcmpgtq %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
;
; XOP-LABEL: gt_v2i64:
; XOP:       # BB#0:
; XOP-NEXT:    vpcomgtuq %xmm1, %xmm0, %xmm0
; XOP-NEXT:    retq
  %1 = icmp ugt <2 x i64> %a, %b
  %2 = sext <2 x i1> %1 to <2 x i64>
  ret <2 x i64> %2
}

define <4 x i32> @gt_v4i32(<4 x i32> %a, <4 x i32> %b) nounwind {
; SSE-LABEL: gt_v4i32:
; SSE:       # BB#0:
; SSE-NEXT:    movdqa {{.*#+}} xmm2 = [2147483648,2147483648,2147483648,2147483648]
; SSE-NEXT:    pxor %xmm2, %xmm1
; SSE-NEXT:    pxor %xmm2, %xmm0
; SSE-NEXT:    pcmpgtd %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX1-LABEL: gt_v4i32:
; AVX1:       # BB#0:
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm2 = [2147483648,2147483648,2147483648,2147483648]
; AVX1-NEXT:    vpxor %xmm2, %xmm1, %xmm1
; AVX1-NEXT:    vpxor %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vpcmpgtd %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: gt_v4i32:
; AVX2:       # BB#0:
; AVX2-NEXT:    vpbroadcastd {{.*}}(%rip), %xmm2
; AVX2-NEXT:    vpxor %xmm2, %xmm1, %xmm1
; AVX2-NEXT:    vpxor %xmm2, %xmm0, %xmm0
; AVX2-NEXT:    vpcmpgtd %xmm1, %xmm0, %xmm0
; AVX2-NEXT:    retq
;
; XOP-LABEL: gt_v4i32:
; XOP:       # BB#0:
; XOP-NEXT:    vpcomgtud %xmm1, %xmm0, %xmm0
; XOP-NEXT:    retq
;
; AVX512-LABEL: gt_v4i32:
; AVX512:       # BB#0:
; AVX512-NEXT:    vpbroadcastd {{.*}}(%rip), %xmm2
; AVX512-NEXT:    vpxor %xmm2, %xmm1, %xmm1
; AVX512-NEXT:    vpxor %xmm2, %xmm0, %xmm0
; AVX512-NEXT:    vpcmpgtd %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    retq
  %1 = icmp ugt <4 x i32> %a, %b
  %2 = sext <4 x i1> %1 to <4 x i32>
  ret <4 x i32> %2
}

define <8 x i16> @gt_v8i16(<8 x i16> %a, <8 x i16> %b) nounwind {
; SSE-LABEL: gt_v8i16:
; SSE:       # BB#0:
; SSE-NEXT:    movdqa {{.*#+}} xmm2 = [32768,32768,32768,32768,32768,32768,32768,32768]
; SSE-NEXT:    pxor %xmm2, %xmm1
; SSE-NEXT:    pxor %xmm2, %xmm0
; SSE-NEXT:    pcmpgtw %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: gt_v8i16:
; AVX:       # BB#0:
; AVX-NEXT:    vmovdqa {{.*#+}} xmm2 = [32768,32768,32768,32768,32768,32768,32768,32768]
; AVX-NEXT:    vpxor %xmm2, %xmm1, %xmm1
; AVX-NEXT:    vpxor %xmm2, %xmm0, %xmm0
; AVX-NEXT:    vpcmpgtw %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
;
; XOP-LABEL: gt_v8i16:
; XOP:       # BB#0:
; XOP-NEXT:    vpcomgtuw %xmm1, %xmm0, %xmm0
; XOP-NEXT:    retq
  %1 = icmp ugt <8 x i16> %a, %b
  %2 = sext <8 x i1> %1 to <8 x i16>
  ret <8 x i16> %2
}

define <16 x i8> @gt_v16i8(<16 x i8> %a, <16 x i8> %b) nounwind {
; SSE-LABEL: gt_v16i8:
; SSE:       # BB#0:
; SSE-NEXT:    movdqa {{.*#+}} xmm2 = [128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128]
; SSE-NEXT:    pxor %xmm2, %xmm1
; SSE-NEXT:    pxor %xmm2, %xmm0
; SSE-NEXT:    pcmpgtb %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: gt_v16i8:
; AVX:       # BB#0:
; AVX-NEXT:    vmovdqa {{.*#+}} xmm2 = [128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128]
; AVX-NEXT:    vpxor %xmm2, %xmm1, %xmm1
; AVX-NEXT:    vpxor %xmm2, %xmm0, %xmm0
; AVX-NEXT:    vpcmpgtb %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
;
; XOP-LABEL: gt_v16i8:
; XOP:       # BB#0:
; XOP-NEXT:    vpcomgtub %xmm1, %xmm0, %xmm0
; XOP-NEXT:    retq
  %1 = icmp ugt <16 x i8> %a, %b
  %2 = sext <16 x i1> %1 to <16 x i8>
  ret <16 x i8> %2
}

;
; Less Than Or Equal
;

define <2 x i64> @le_v2i64(<2 x i64> %a, <2 x i64> %b) nounwind {
; SSE2-LABEL: le_v2i64:
; SSE2:       # BB#0:
; SSE2-NEXT:    movdqa {{.*#+}} xmm2 = [2147483648,2147483648,2147483648,2147483648]
; SSE2-NEXT:    pxor %xmm2, %xmm1
; SSE2-NEXT:    pxor %xmm2, %xmm0
; SSE2-NEXT:    movdqa %xmm0, %xmm2
; SSE2-NEXT:    pcmpgtd %xmm1, %xmm2
; SSE2-NEXT:    pshufd {{.*#+}} xmm3 = xmm2[0,0,2,2]
; SSE2-NEXT:    pcmpeqd %xmm1, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[1,1,3,3]
; SSE2-NEXT:    pand %xmm3, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm2[1,1,3,3]
; SSE2-NEXT:    por %xmm0, %xmm1
; SSE2-NEXT:    pcmpeqd %xmm0, %xmm0
; SSE2-NEXT:    pxor %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: le_v2i64:
; SSE41:       # BB#0:
; SSE41-NEXT:    movdqa {{.*#+}} xmm2 = [2147483648,2147483648,2147483648,2147483648]
; SSE41-NEXT:    pxor %xmm2, %xmm1
; SSE41-NEXT:    pxor %xmm2, %xmm0
; SSE41-NEXT:    movdqa %xmm0, %xmm2
; SSE41-NEXT:    pcmpgtd %xmm1, %xmm2
; SSE41-NEXT:    pshufd {{.*#+}} xmm3 = xmm2[0,0,2,2]
; SSE41-NEXT:    pcmpeqd %xmm1, %xmm0
; SSE41-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[1,1,3,3]
; SSE41-NEXT:    pand %xmm3, %xmm0
; SSE41-NEXT:    pshufd {{.*#+}} xmm1 = xmm2[1,1,3,3]
; SSE41-NEXT:    por %xmm0, %xmm1
; SSE41-NEXT:    pcmpeqd %xmm0, %xmm0
; SSE41-NEXT:    pxor %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; SSE42-LABEL: le_v2i64:
; SSE42:       # BB#0:
; SSE42-NEXT:    movdqa {{.*#+}} xmm2 = [9223372036854775808,9223372036854775808]
; SSE42-NEXT:    pxor %xmm2, %xmm1
; SSE42-NEXT:    pxor %xmm2, %xmm0
; SSE42-NEXT:    pcmpgtq %xmm1, %xmm0
; SSE42-NEXT:    pcmpeqd %xmm1, %xmm1
; SSE42-NEXT:    pxor %xmm1, %xmm0
; SSE42-NEXT:    retq
;
; AVX-LABEL: le_v2i64:
; AVX:       # BB#0:
; AVX-NEXT:    vmovdqa {{.*#+}} xmm2 = [9223372036854775808,9223372036854775808]
; AVX-NEXT:    vpxor %xmm2, %xmm1, %xmm1
; AVX-NEXT:    vpxor %xmm2, %xmm0, %xmm0
; AVX-NEXT:    vpcmpgtq %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpcmpeqd %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vpxor %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
;
; XOP-LABEL: le_v2i64:
; XOP:       # BB#0:
; XOP-NEXT:    vpcomleuq %xmm1, %xmm0, %xmm0
; XOP-NEXT:    retq
  %1 = icmp ule <2 x i64> %a, %b
  %2 = sext <2 x i1> %1 to <2 x i64>
  ret <2 x i64> %2
}

define <4 x i32> @le_v4i32(<4 x i32> %a, <4 x i32> %b) nounwind {
; SSE2-LABEL: le_v4i32:
; SSE2:       # BB#0:
; SSE2-NEXT:    movdqa {{.*#+}} xmm2 = [2147483648,2147483648,2147483648,2147483648]
; SSE2-NEXT:    pxor %xmm2, %xmm1
; SSE2-NEXT:    pxor %xmm2, %xmm0
; SSE2-NEXT:    pcmpgtd %xmm1, %xmm0
; SSE2-NEXT:    pcmpeqd %xmm1, %xmm1
; SSE2-NEXT:    pxor %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: le_v4i32:
; SSE41:       # BB#0:
; SSE41-NEXT:    pminud %xmm0, %xmm1
; SSE41-NEXT:    pcmpeqd %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; SSE42-LABEL: le_v4i32:
; SSE42:       # BB#0:
; SSE42-NEXT:    pminud %xmm0, %xmm1
; SSE42-NEXT:    pcmpeqd %xmm1, %xmm0
; SSE42-NEXT:    retq
;
; AVX-LABEL: le_v4i32:
; AVX:       # BB#0:
; AVX-NEXT:    vpminud %xmm1, %xmm0, %xmm1
; AVX-NEXT:    vpcmpeqd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
;
; XOP-LABEL: le_v4i32:
; XOP:       # BB#0:
; XOP-NEXT:    vpcomleud %xmm1, %xmm0, %xmm0
; XOP-NEXT:    retq
  %1 = icmp ule <4 x i32> %a, %b
  %2 = sext <4 x i1> %1 to <4 x i32>
  ret <4 x i32> %2
}

define <8 x i16> @le_v8i16(<8 x i16> %a, <8 x i16> %b) nounwind {
; SSE2-LABEL: le_v8i16:
; SSE2:       # BB#0:
; SSE2-NEXT:    psubusw %xmm1, %xmm0
; SSE2-NEXT:    pxor %xmm1, %xmm1
; SSE2-NEXT:    pcmpeqw %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: le_v8i16:
; SSE41:       # BB#0:
; SSE41-NEXT:    pminuw %xmm0, %xmm1
; SSE41-NEXT:    pcmpeqw %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; SSE42-LABEL: le_v8i16:
; SSE42:       # BB#0:
; SSE42-NEXT:    pminuw %xmm0, %xmm1
; SSE42-NEXT:    pcmpeqw %xmm1, %xmm0
; SSE42-NEXT:    retq
;
; AVX-LABEL: le_v8i16:
; AVX:       # BB#0:
; AVX-NEXT:    vpminuw %xmm1, %xmm0, %xmm1
; AVX-NEXT:    vpcmpeqw %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
;
; XOP-LABEL: le_v8i16:
; XOP:       # BB#0:
; XOP-NEXT:    vpcomleuw %xmm1, %xmm0, %xmm0
; XOP-NEXT:    retq
  %1 = icmp ule <8 x i16> %a, %b
  %2 = sext <8 x i1> %1 to <8 x i16>
  ret <8 x i16> %2
}

define <16 x i8> @le_v16i8(<16 x i8> %a, <16 x i8> %b) nounwind {
; SSE-LABEL: le_v16i8:
; SSE:       # BB#0:
; SSE-NEXT:    pminub %xmm0, %xmm1
; SSE-NEXT:    pcmpeqb %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: le_v16i8:
; AVX:       # BB#0:
; AVX-NEXT:    vpminub %xmm1, %xmm0, %xmm1
; AVX-NEXT:    vpcmpeqb %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
;
; XOP-LABEL: le_v16i8:
; XOP:       # BB#0:
; XOP-NEXT:    vpcomleub %xmm1, %xmm0, %xmm0
; XOP-NEXT:    retq
  %1 = icmp ule <16 x i8> %a, %b
  %2 = sext <16 x i1> %1 to <16 x i8>
  ret <16 x i8> %2
}

;
; Less Than
;

define <2 x i64> @lt_v2i64(<2 x i64> %a, <2 x i64> %b) nounwind {
; SSE2-LABEL: lt_v2i64:
; SSE2:       # BB#0:
; SSE2-NEXT:    movdqa {{.*#+}} xmm2 = [2147483648,2147483648,2147483648,2147483648]
; SSE2-NEXT:    pxor %xmm2, %xmm0
; SSE2-NEXT:    pxor %xmm2, %xmm1
; SSE2-NEXT:    movdqa %xmm1, %xmm2
; SSE2-NEXT:    pcmpgtd %xmm0, %xmm2
; SSE2-NEXT:    pshufd {{.*#+}} xmm3 = xmm2[0,0,2,2]
; SSE2-NEXT:    pcmpeqd %xmm0, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE2-NEXT:    pand %xmm3, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm2[1,1,3,3]
; SSE2-NEXT:    por %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: lt_v2i64:
; SSE41:       # BB#0:
; SSE41-NEXT:    movdqa {{.*#+}} xmm2 = [2147483648,2147483648,2147483648,2147483648]
; SSE41-NEXT:    pxor %xmm2, %xmm0
; SSE41-NEXT:    pxor %xmm2, %xmm1
; SSE41-NEXT:    movdqa %xmm1, %xmm2
; SSE41-NEXT:    pcmpgtd %xmm0, %xmm2
; SSE41-NEXT:    pshufd {{.*#+}} xmm3 = xmm2[0,0,2,2]
; SSE41-NEXT:    pcmpeqd %xmm0, %xmm1
; SSE41-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE41-NEXT:    pand %xmm3, %xmm1
; SSE41-NEXT:    pshufd {{.*#+}} xmm0 = xmm2[1,1,3,3]
; SSE41-NEXT:    por %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; SSE42-LABEL: lt_v2i64:
; SSE42:       # BB#0:
; SSE42-NEXT:    movdqa {{.*#+}} xmm2 = [9223372036854775808,9223372036854775808]
; SSE42-NEXT:    pxor %xmm2, %xmm0
; SSE42-NEXT:    pxor %xmm1, %xmm2
; SSE42-NEXT:    pcmpgtq %xmm0, %xmm2
; SSE42-NEXT:    movdqa %xmm2, %xmm0
; SSE42-NEXT:    retq
;
; AVX-LABEL: lt_v2i64:
; AVX:       # BB#0:
; AVX-NEXT:    vmovdqa {{.*#+}} xmm2 = [9223372036854775808,9223372036854775808]
; AVX-NEXT:    vpxor %xmm2, %xmm0, %xmm0
; AVX-NEXT:    vpxor %xmm2, %xmm1, %xmm1
; AVX-NEXT:    vpcmpgtq %xmm0, %xmm1, %xmm0
; AVX-NEXT:    retq
;
; XOP-LABEL: lt_v2i64:
; XOP:       # BB#0:
; XOP-NEXT:    vpcomltuq %xmm1, %xmm0, %xmm0
; XOP-NEXT:    retq
  %1 = icmp ult <2 x i64> %a, %b
  %2 = sext <2 x i1> %1 to <2 x i64>
  ret <2 x i64> %2
}

define <4 x i32> @lt_v4i32(<4 x i32> %a, <4 x i32> %b) nounwind {
; SSE-LABEL: lt_v4i32:
; SSE:       # BB#0:
; SSE-NEXT:    movdqa {{.*#+}} xmm2 = [2147483648,2147483648,2147483648,2147483648]
; SSE-NEXT:    pxor %xmm2, %xmm0
; SSE-NEXT:    pxor %xmm1, %xmm2
; SSE-NEXT:    pcmpgtd %xmm0, %xmm2
; SSE-NEXT:    movdqa %xmm2, %xmm0
; SSE-NEXT:    retq
;
; AVX1-LABEL: lt_v4i32:
; AVX1:       # BB#0:
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm2 = [2147483648,2147483648,2147483648,2147483648]
; AVX1-NEXT:    vpxor %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vpxor %xmm2, %xmm1, %xmm1
; AVX1-NEXT:    vpcmpgtd %xmm0, %xmm1, %xmm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: lt_v4i32:
; AVX2:       # BB#0:
; AVX2-NEXT:    vpbroadcastd {{.*}}(%rip), %xmm2
; AVX2-NEXT:    vpxor %xmm2, %xmm0, %xmm0
; AVX2-NEXT:    vpxor %xmm2, %xmm1, %xmm1
; AVX2-NEXT:    vpcmpgtd %xmm0, %xmm1, %xmm0
; AVX2-NEXT:    retq
;
; XOP-LABEL: lt_v4i32:
; XOP:       # BB#0:
; XOP-NEXT:    vpcomltud %xmm1, %xmm0, %xmm0
; XOP-NEXT:    retq
;
; AVX512-LABEL: lt_v4i32:
; AVX512:       # BB#0:
; AVX512-NEXT:    vpbroadcastd {{.*}}(%rip), %xmm2
; AVX512-NEXT:    vpxor %xmm2, %xmm0, %xmm0
; AVX512-NEXT:    vpxor %xmm2, %xmm1, %xmm1
; AVX512-NEXT:    vpcmpgtd %xmm0, %xmm1, %xmm0
; AVX512-NEXT:    retq
  %1 = icmp ult <4 x i32> %a, %b
  %2 = sext <4 x i1> %1 to <4 x i32>
  ret <4 x i32> %2
}

define <8 x i16> @lt_v8i16(<8 x i16> %a, <8 x i16> %b) nounwind {
; SSE-LABEL: lt_v8i16:
; SSE:       # BB#0:
; SSE-NEXT:    movdqa {{.*#+}} xmm2 = [32768,32768,32768,32768,32768,32768,32768,32768]
; SSE-NEXT:    pxor %xmm2, %xmm0
; SSE-NEXT:    pxor %xmm1, %xmm2
; SSE-NEXT:    pcmpgtw %xmm0, %xmm2
; SSE-NEXT:    movdqa %xmm2, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: lt_v8i16:
; AVX:       # BB#0:
; AVX-NEXT:    vmovdqa {{.*#+}} xmm2 = [32768,32768,32768,32768,32768,32768,32768,32768]
; AVX-NEXT:    vpxor %xmm2, %xmm0, %xmm0
; AVX-NEXT:    vpxor %xmm2, %xmm1, %xmm1
; AVX-NEXT:    vpcmpgtw %xmm0, %xmm1, %xmm0
; AVX-NEXT:    retq
;
; XOP-LABEL: lt_v8i16:
; XOP:       # BB#0:
; XOP-NEXT:    vpcomltuw %xmm1, %xmm0, %xmm0
; XOP-NEXT:    retq
  %1 = icmp ult <8 x i16> %a, %b
  %2 = sext <8 x i1> %1 to <8 x i16>
  ret <8 x i16> %2
}

define <16 x i8> @lt_v16i8(<16 x i8> %a, <16 x i8> %b) nounwind {
; SSE-LABEL: lt_v16i8:
; SSE:       # BB#0:
; SSE-NEXT:    movdqa {{.*#+}} xmm2 = [128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128]
; SSE-NEXT:    pxor %xmm2, %xmm0
; SSE-NEXT:    pxor %xmm1, %xmm2
; SSE-NEXT:    pcmpgtb %xmm0, %xmm2
; SSE-NEXT:    movdqa %xmm2, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: lt_v16i8:
; AVX:       # BB#0:
; AVX-NEXT:    vmovdqa {{.*#+}} xmm2 = [128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128]
; AVX-NEXT:    vpxor %xmm2, %xmm0, %xmm0
; AVX-NEXT:    vpxor %xmm2, %xmm1, %xmm1
; AVX-NEXT:    vpcmpgtb %xmm0, %xmm1, %xmm0
; AVX-NEXT:    retq
;
; XOP-LABEL: lt_v16i8:
; XOP:       # BB#0:
; XOP-NEXT:    vpcomltub %xmm1, %xmm0, %xmm0
; XOP-NEXT:    retq
  %1 = icmp ult <16 x i8> %a, %b
  %2 = sext <16 x i1> %1 to <16 x i8>
  ret <16 x i8> %2
}
