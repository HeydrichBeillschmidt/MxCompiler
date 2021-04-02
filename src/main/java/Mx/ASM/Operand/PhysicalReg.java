package Mx.ASM.Operand;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

public class PhysicalReg extends Reg {
    public static ArrayList<String> phyRegNames = new ArrayList<>(Arrays.asList(
            "zero", "ra", "sp", "gp", "tp",
            "t0", "t1", "t2", "s0", "s1",
            "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7",
            "s2", "s3", "s4", "s5", "s6", "s7", "s8", "s9", "s10", "s11",
            "t3", "t4", "t5", "t6"
    ));
    private static final ArrayList<Integer> saveStatus = new ArrayList<>(Arrays.asList(
            0,1,0,0,0,
            1,1,1,2,2,
            1,1,1,1,1,1,1,1,
            2,2,2,2,2,2,2,2,2,2,
            1,1,1,1
    ));
    public static Map<String, PhysicalReg> phyRegs;
    public static ArrayList<PhysicalReg> callerSavePhyRegs;
    public static ArrayList<PhysicalReg> calleeSavePhyRegs;
    public static ArrayList<PhysicalReg> assignablePhyRegs;

    public static Map<String, VirtualReg> virtualRegs;
    public static VirtualReg zeroVR;
    public static VirtualReg raVR;
    public static VirtualReg spVR;
    public static ArrayList<VirtualReg> argVRs;
    public static ArrayList<VirtualReg> callerSaveVRs;
    public static ArrayList<VirtualReg> calleeSaveVRs;

    static {
        phyRegs = new HashMap<>();
        callerSavePhyRegs = new ArrayList<>();
        calleeSavePhyRegs = new ArrayList<>();
        assignablePhyRegs = new ArrayList<>();
        for (int i = 0; i < 32; ++i) {
            String prName = phyRegNames.get(i);
            PhysicalReg pr = new PhysicalReg(prName);
            phyRegs.put(prName, pr);
            switch (saveStatus.get(i)) {
                case 1: {
                    callerSavePhyRegs.add(pr);
                    break;
                }
                case 2: {
                    calleeSavePhyRegs.add(pr);
                }
            }
        }
        assignablePhyRegs.addAll(callerSavePhyRegs);
        assignablePhyRegs.addAll(calleeSavePhyRegs);
        assignablePhyRegs.remove(0);
        assignablePhyRegs.add(phyRegs.get("ra"));

        virtualRegs = new HashMap<>();
        for (var prn: phyRegNames) {
            VirtualReg vr = new VirtualReg(4, "."+prn);
            vr.fixColor(phyRegs.get(prn));
            virtualRegs.put(prn, vr);
        }
        zeroVR = virtualRegs.get("zero");
        raVR = virtualRegs.get("ra");
        spVR = virtualRegs.get("sp");
        argVRs = new ArrayList<>();
        for (int i = 0; i < 8; ++i) {
            argVRs.add(virtualRegs.get("a"+i));
        }
        callerSaveVRs = new ArrayList<>();
        calleeSaveVRs = new ArrayList<>();
        callerSavePhyRegs.forEach(p -> callerSaveVRs.add(virtualRegs.get(p.getName())));
        calleeSavePhyRegs.forEach(p -> calleeSaveVRs.add(virtualRegs.get(p.getName())));
    }

    public PhysicalReg(String name) {
        super(name);
    }

    @Override
    public String emitCode() {
        return getName();
    }
}
