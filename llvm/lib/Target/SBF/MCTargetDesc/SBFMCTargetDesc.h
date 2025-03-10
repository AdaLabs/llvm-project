//===-- SBFMCTargetDesc.h - SBF Target Descriptions -------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file provides SBF specific target descriptions.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_SBF_MCTARGETDESC_SBFMCTARGETDESC_H
#define LLVM_LIB_TARGET_SBF_MCTARGETDESC_SBFMCTARGETDESC_H

#include "llvm/Config/config.h"
#include "llvm/Support/DataTypes.h"

#include <memory>

namespace llvm {
class MCAsmBackend;
class MCCodeEmitter;
class MCContext;
class MCInstrInfo;
class MCObjectTargetWriter;
class MCRegisterInfo;
class MCSubtargetInfo;
class MCTargetOptions;
class Target;

MCCodeEmitter *createSBFMCCodeEmitter(const MCInstrInfo &MCII,
                                      const MCRegisterInfo &MRI,
                                      MCContext &Ctx);
MCCodeEmitter *createSBFbeMCCodeEmitter(const MCInstrInfo &MCII,
                                        const MCRegisterInfo &MRI,
                                        MCContext &Ctx);

MCAsmBackend *createSBFAsmBackend(const Target &T, const MCSubtargetInfo &STI,
                                  const MCRegisterInfo &MRI,
                                  const MCTargetOptions &Options);
MCAsmBackend *createSBFbeAsmBackend(const Target &T, const MCSubtargetInfo &STI,
                                    const MCRegisterInfo &MRI,
                                    const MCTargetOptions &Options);

std::unique_ptr<MCObjectTargetWriter>
createSBFELFObjectWriter(uint8_t OSABI, bool isSolana, bool useRelocAbs64);
} // namespace llvm

// Defines symbolic names for SBF registers.  This defines a mapping from
// register name to register number.
//
#define GET_REGINFO_ENUM
#include "SBFGenRegisterInfo.inc"

// Defines symbolic names for the SBF instructions.
//
#define GET_INSTRINFO_ENUM
#include "SBFGenInstrInfo.inc"

#define GET_SUBTARGETINFO_ENUM
#include "SBFGenSubtargetInfo.inc"

#endif
