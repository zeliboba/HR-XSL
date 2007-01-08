// This class is a hack to work around Ant bug #41314: http://issues.apache.org/bugzilla/show_bug.cgi?id=41314

import org.apache.tools.ant.taskdefs.optional.TraXLiaison;
import java.io.File;

public class SaxonLiaison extends TraXLiaison
{
    private final static String TRANSFORM_PROP =
        "javax.xml.transform.TransformerFactory";
    private final static String SAXON_FACTORY =
        "net.sf.saxon.TransformerFactoryImpl";
    
    public SaxonLiaison() throws Exception {}
    
    public void transform(File infile, File outfile) throws Exception
    {
        String oldProperty = System.setProperty(
            TRANSFORM_PROP, SAXON_FACTORY);
            
        super.transform(infile, outfile);

        if (oldProperty == null)
            System.clearProperty(TRANSFORM_PROP);
        else
            System.setProperty(TRANSFORM_PROP, oldProperty);
    }
}
